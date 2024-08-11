#ifndef RACE_SINGLEWRITER_H_
#define RACE_SINGLEWRITER_H_

#include "AtomicMath.h"


struct SwmrSyncHandle final {
    volatile uint32_t n_readers {0};
    volatile bool write_pending {false};

    SwmrSyncHandle()    = default;
    ~SwmrSyncHandle()   = default;
    SwmrSyncHandle(const SwmrSyncHandle&)               = delete;
    SwmrSyncHandle(SwmrSyncHandle&&)                    = delete;
    SwmrSyncHandle& operator=(const SwmrSyncHandle&)    = delete;
    SwmrSyncHandle& operator=(SwmrSyncHandle&&)         = delete;
};

class SingleWriterLock final {
  public:
    SingleWriterLock(SwmrSyncHandle& h) : sync_handle{h} {
        __asm("DISABLE" : : : "memory");
        sync_handle.write_pending = true;
        __asm("DSYNC" : : : "memory");
        while (sync_handle.n_readers != 0) {
            /* Wait until all readers finish reading */
        }
        __asm("" : : : "memory");
    }

    ~SingleWriterLock() {
        __asm("" : : : "memory");
        sync_handle.write_pending = false;
        __asm("DSYNC" : : : "memory");
        __asm("ENABLE" : : : "memory");
    }

  private:
    SwmrSyncHandle& sync_handle;
    SingleWriterLock(const SingleWriterLock&)               = delete;
    SingleWriterLock(SingleWriterLock&&)                    = delete;
    SingleWriterLock& operator=(const SingleWriterLock&)    = delete;
    SingleWriterLock& operator=(SingleWriterLock&&)         = delete;
};

class MultiReaderLock final {
  public:
    MultiReaderLock(SwmrSyncHandle& h) : sync_handle{h} {
        for ( ; ; ) {
            while (sync_handle.write_pending) {
                __asm("NOP" : : : "memory");
                __asm("NOP" : : : "memory");
                __asm("NOP" : : : "memory");
            }
            __asm("DISABLE" : : : "memory");
            atomic_add(&sync_handle.n_readers, 1);
            __asm("DSYNC" : : : "memory");
            if (sync_handle.write_pending) {
                atomic_sub(&sync_handle.n_readers, 1);
                __asm("DSYNC" : : : "memory");
                __asm("ENABLE" : : : "memory");
            } else {
                break;
            }
        }
    }

    ~MultiReaderLock() {
        __asm("" : : : "memory");
        atomic_sub(&sync_handle.n_readers, 1);
        __asm("DSYNC" : : : "memory");
        __asm("ENABLE" : : : "memory");
    }

  private:
    SwmrSyncHandle& sync_handle;
    MultiReaderLock(const MultiReaderLock&)                 = delete;
    MultiReaderLock(MultiReaderLock&&)                      = delete;
    MultiReaderLock& operator=(const MultiReaderLock&)      = delete;
    MultiReaderLock& operator=(MultiReaderLock&&)           = delete;
};

#endif /* RACE_SINGLEWRITER_H_ */
