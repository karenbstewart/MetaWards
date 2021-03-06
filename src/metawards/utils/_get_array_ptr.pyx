
cdef double * get_double_array_ptr(double_array):
    """Return the raw C pointer to the passed double array which was
       created using create_double_array
    """
    cdef double [::1] a = double_array
    return &(a[0])


cdef int * get_int_array_ptr(int_array):
    """Return the raw C pointer to the passed int array which was
       created using create_int_array
    """
    cdef int [::1] a = int_array
    return &(a[0])
