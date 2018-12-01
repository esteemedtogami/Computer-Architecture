#include <stdio.h>
#include <iostream>

typedef union{
        float   floating_value_in_32_bits;
        int     arg_32;
        struct  sign_exp_mantissa{
                unsigned  mantissa:23;
                unsigned  exponent:8;
                unsigned      sign:1;
        } f_bits;
	struct single_bits{
		unsigned  b0 :1;
		unsigned  b1 :1;
		unsigned  b2 :1;
		unsigned  b3 :1;
		unsigned  b4 :1;
		unsigned  b5 :1;
		unsigned  b6 :1;
		unsigned  b7 :1;
		unsigned  b8 :1;
		unsigned  b9 :1;
		unsigned  b10:1;
		unsigned  b11:1;
		unsigned  b12:1;
		unsigned  b13:1;
		unsigned  b14:1;
		unsigned  b15:1;
		unsigned  b16:1;
		unsigned  b17:1;
		unsigned  b18:1;
		unsigned  b19:1;
		unsigned  b20:1;
		unsigned  b21:1;
		unsigned  b22:1;
		unsigned  b23:1;
		unsigned  b24:1;
		unsigned  b25:1;
		unsigned  b26:1;
		unsigned  b27:1;
		unsigned  b28:1;
		unsigned  b29:1;
		unsigned  b30:1;
		unsigned  b31:1;
	}bit;
}FLOAT_UN;

void print_bits(FLOAT_UN float_32);

int main(int argc, char* argv[])
{
  FLOAT_UN float_32_s1, float_32_s2, fun_arg, float_32_result;

  float the_hardware_result;
  int mant_s1, mant_s2, exp_s1, exp_s2, mant_res, exp_res, sign_res;
  int shift_count;

  std::cout << "Please enter your first floating point number and new-line: ";
  std::cin >> float_32_s1.floating_value_in_32_bits;
  std::cout << std::endl;

  std::cout << "Please enter your second floating point number and new-line: ";
  std::cin >> float_32_s2.floating_value_in_32_bits;
  std::cout << std::endl;

  the_hardware_result = float_32_s2.floating_value_in_32_bits +
    float_32_s1.floating_value_in_32_bits;

  std::cout << "First float in binary: " << std::endl;
  print_bits(float_32_s1);
  std::cout << std::endl;

  std::cout << "Second float in binary: " << std::endl;
  print_bits(float_32_s2);
  std::cout << std::endl;

  mant_s1 = float_32_s1.f_bits.mantissa;
  mant_s2 = float_32_s2.f_bits.mantissa;
  exp_s1 = float_32_s1.f_bits.exponent;
  exp_s2 = float_32_s2.f_bits.exponent;

  if (exp_s1)
    {
      mant_s1 |= (1 << 23);
    }
  if (exp_s2)
    {
      mant_s2 |= (1 << 23);
    }

  fun_arg.arg_32 = mant_s1;
  std::cout << std::endl;
  std::cout << "Mantissa s1: ";
  print_bits(fun_arg);
  std::cout << std::endl;

  fun_arg.arg_32 = mant_s2;
  std::cout << std::endl;
  std::cout << "Mantissa s2: ";
  print_bits(fun_arg);
  std::cout << std::endl;

  if ((shift_count = exp_s1 - exp_s2) < 0)
    {
      shift_count = -(shift_count);
      if (shift_count > 24) shift_count = 24;
      mant_s1 = mant_s1 >> shift_count;
      sign_res = 1;
      exp_res = exp_s2;
    }
  //Started writing from here
  else
    {
      shift_count = exp_s2 - exp_s1;
      shift_count = -(shift_count);
      if (shift_count > 24) shift_count = 24;
      mant_s2 = mant_s2 >> shift_count;
      sign_res = 0;
      exp_res = exp_s1;
    }

  fun_arg.arg_32 = mant_s1;
  std::cout << std::endl;
  std::cout << "Mantissa s1 AFTER SHIFT: ";
  print_bits(fun_arg);
  std::cout << std::endl;

  fun_arg.arg_32 = mant_s2;
  std::cout << std::endl;
  std::cout << "Mantissa s2 AFTER SHIFT: ";
  print_bits(fun_arg);
  std::cout << std::endl;

  mant_res = mant_s1 + mant_s2;
  fun_arg.arg_32 = mant_res;
  std::cout << std::endl;
  std::cout << "Bit sums before adjustment: ";
  print_bits(fun_arg);
  std::cout << std::endl;

  if (((mant_res << 24) & 1) == 0)
    {
      //do nothing
    }
  else
    {
      mant_res = (mant_res >> 1);
      exp_res ++;
    }

  float_32_result.f_bits.sign = sign_res;
  float_32_result.f_bits.exponent = exp_res;
  float_32_result.f_bits.mantissa = mant_res;

  fun_arg.arg_32 = mant_res;
  std::cout << std::endl;
  std::cout << "Bit sums after adjustment: ";
  print_bits(fun_arg);
  std::cout << std::endl;

  std::cout << std::endl;
  std::cout << "Bit pattern result: ";
  print_bits(float_32_result);
  std::cout << std::endl;

  std::cout << "Emulated result from std::cout: "
	    << float_32_result.floating_value_in_32_bits << std::endl;
  std::cout << "Hardware result from std::cout: " << the_hardware_result
            << std::endl;
  
}


void print_bits(FLOAT_UN float_32)
{
  char bit_string[43];
  int i;

  for(i=0; i<42; i++){
	bit_string[i] = ' ';
  }
  bit_string[42] = '\0';

bit_string[0] = float_32.bit.b31?'1':'0';

bit_string[2] = float_32.bit.b30?'1':'0';
bit_string[3] = float_32.bit.b29?'1':'0';
bit_string[4] = float_32.bit.b28?'1':'0';
bit_string[5] = float_32.bit.b27?'1':'0';

bit_string[7] = float_32.bit.b26?'1':'0';
bit_string[8] = float_32.bit.b25?'1':'0';
bit_string[9] = float_32.bit.b24?'1':'0';
bit_string[10] = float_32.bit.b23?'1':'0';

bit_string[12] = float_32.bit.b22?'1':'0';
bit_string[13] = float_32.bit.b21?'1':'0';
bit_string[14] = float_32.bit.b20?'1':'0';

bit_string[16] = float_32.bit.b19?'1':'0';
bit_string[17] = float_32.bit.b18?'1':'0';
bit_string[18] = float_32.bit.b17?'1':'0';
bit_string[19] = float_32.bit.b16?'1':'0';

bit_string[21] = float_32.bit.b15?'1':'0';
bit_string[22] = float_32.bit.b14?'1':'0';
bit_string[23] = float_32.bit.b13?'1':'0';
bit_string[24] = float_32.bit.b12?'1':'0';

bit_string[26] = float_32.bit.b11?'1':'0';
bit_string[27] = float_32.bit.b10?'1':'0';
bit_string[28] = float_32.bit.b9?'1':'0';
bit_string[29] = float_32.bit.b8?'1':'0';

bit_string[31] = float_32.bit.b7?'1':'0';
bit_string[32] = float_32.bit.b6?'1':'0';
bit_string[33] = float_32.bit.b5?'1':'0';
bit_string[34] = float_32.bit.b4?'1':'0';

bit_string[36] = float_32.bit.b3?'1':'0';
bit_string[37] = float_32.bit.b2?'1':'0';
bit_string[38] = float_32.bit.b1?'1':'0';
bit_string[39] = float_32.bit.b0?'1':'0';

 std::cout.width(23);
 std::cout << bit_string;
}
