#include "ruby.h"
#include <stdint.h>
#include <math.h>

extern uint32_t _solve(uint32_t, uint32_t, uint32_t);

VALUE quantbet = Qnil;

uint32_t lower(uint32_t a, uint32_t b){
    // Return the lower of the two inputs
    return a<b?a:b;
}

VALUE method_find_highest_divisor(VALUE self, VALUE a, VALUE b) {
    // Declare and set variables
    uint32_t a_n, b_n = 0;
    uint32_t startingpoint = 0;
    uint32_t magicnumber = 0;

    // Cast the incoming variables as uint32_t to make them easier to work with
    a_n = (uint32_t)NUM2INT(a);
    b_n = (uint32_t)NUM2INT(b);

    // Calculate the largest divisor of the smallest number by square rooting it.
    // We use this number as the starting point and will count down from there
    startingpoint = (uint32_t)floor(sqrt(lower(a_n, b_n)));

    // Throw these numbers at the processor and return the result
    magicnumber = _solve(a_n, b_n, startingpoint);
    return INT2NUM(magicnumber);
}

void Init_quantbet(){
    quantbet = rb_define_class("Quantbet", rb_cObject);
    rb_define_method(quantbet, "find_highest_divisor", method_find_highest_divisor, 2);
}
