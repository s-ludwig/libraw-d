module libraw.alloc;

import libraw.const_;

import core.stdc.stdlib;
import core.stdc.string;


enum LIBRAW_MSIZE = 512;

extern(C++) class libraw_memmgr;

/+extern(C++) class libraw_memmgr {
  this(unsigned ee) 
  {
    extra_bytes = ee;
    size_t alloc_sz = LIBRAW_MSIZE * (void*).sizeof;
    mems = cast(void**).malloc(alloc_sz);
    memset(mems, 0, alloc_sz);
  }
  ~this()
  {
    cleanup();
    .free(mems);
  }
  void *malloc(size_t sz)
  {
    version (LIBRAW_USE_CALLOC_INSTEAD_OF_MALLOC) {
      void *ptr = .calloc(sz + extra_bytes,1);
    } else {
      void *ptr = .malloc(sz + extra_bytes);
    }
    mem_ptr(ptr);
    return ptr;
  }
  void *calloc(size_t n, size_t sz)
  {
    void *ptr = .calloc(n + (extra_bytes + sz - 1) / (sz ? sz : 1), sz);
    mem_ptr(ptr);
    return ptr;
  }
  void *realloc(void *ptr, size_t newsz)
  {
    void *ret = .realloc(ptr, newsz + extra_bytes);
    forget_ptr(ptr);
    mem_ptr(ret);
    return ret;
  }
  void free(void *ptr)
  {
    forget_ptr(ptr);
    .free(ptr);
  }
  void cleanup(void)
  {
    for (int i = 0; i < LIBRAW_MSIZE; i++)
      if (mems[i])
      {
        .free(mems[i]);
        mems[i] = NULL;
      }
  }

private:
  void **mems;
  unsigned extra_bytes;
  void mem_ptr(void *ptr)
  {
    if (ptr)
    {
      for (int i = 0; i < LIBRAW_MSIZE-1; i++)
        if (!mems[i])
        {
          mems[i] = ptr;
          return;
        }
      version (LIBRAW_MEMPOOL_CHECK) {
        /* remember ptr in last mems item to be free'ed at cleanup */
        if(!mems[LIBRAW_MSIZE-1]) mems[LIBRAW_MSIZE-1] = ptr;
        throw LIBRAW_EXCEPTION_MEMPOOL;
      }
    }
  }
  void forget_ptr(void *ptr)
  {
    if (ptr)
      for (int i = 0; i < LIBRAW_MSIZE; i++)
        if (mems[i] == ptr)
        {
          mems[i] = NULL;
          break;
        }
  }
}+/
