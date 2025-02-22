#Requires AutoHotkey v2.0

; AHK v2 library implementing Matrix objects

#Include AHKUsefulLib.ahk

Pi := 3.141592653589793

class Complex 
{
    real := unset
    imag := unset

    __New(real_, imag_)
    {
        If !IsNumber(real_) || !IsNumber(imag_)
            throw ValueError("Complex numbers must be created using numbers numbers. Here: Type(real=" real_ ") = " Type(real_) ", Type(imag=" imag_ ") = " Type(imag_))
            
        this.real := real_
        this.imag := imag_
    }

    /* Complex.Scaled(factor) : Returns current complex instance multiplied by given number.
    * Args:
    *   factor (Complex | Number): The number to multiply the current complex instance by
    * Returns:
    *   Complex: The current complex instance multiplied by the given number */
    Scaled(factor)
    {
        If factor is Complex {
            real := this.real * factor.real - this.imag * factor.imag
            imag := this.real * factor.imag + this.imag * factor.real
            return Complex(real, imag)
        } Else If IsNumber(factor) {
            real := this.real * factor
            imag := this.imag * factor
            return Complex(real, imag)
        } Else {
            throw ValueError("Complex numbers can only be scaled by a Complex number or a real number. Here: Type(factor=" factor ") = " Type(factor))
        }
    }

    /* Complex.Conjugate() : Returns the conjugate of the current complex instance.
    * Returns:
    *   Complex: The conjugate of the current complex instance */
    Conjugate()
    {
        return Complex(this.real, -this.imag)
    }

    /* Complex.Abs() : Returns the absolute value of the current complex instance.
    * Returns:
    *   Number: The absolute value of the current complex instance */
    Abs()
    {
        return Sqrt(this.real ** 2 + this.imag ** 2)
    }

    /* Complex.Arg() : Returns the argument of the current complex instance.
    * Returns:
    *   Number: The argument of the current complex instance 
    * 
    * Note: Will throw an error if the argument of 0 + 0i is requested. */
    Arg() {
        global Pi
        If this.real = 0 && this.imag = 0
            throw ValueError("Argument of 0 + 0i is undefined.")
        Else If this.real > 0 
            return ATan(this.imag / this.real)
        Else If this.real < 0 && this.imag >= 0
            return ATan(this.imag / this.real) + Pi
        Else If this.real < 0 && this.imag < 0
            return ATan(this.imag / this.real) - Pi
        Else If this.real = 0 && this.imag > 0
            return Pi / 2
        Else If this.real = 0 && this.imag < 0
            return -Pi / 2
    }
}

ComplexMult(a, b)
{
    If !(a is Complex) || !(b is Complex)
        throw ValueError("Complex numbers can only be multiplied by Complex numbers. Here: Type(a=" a ") = " Type(a) ", Type(b=" b ") = " Type(b))
    
    real := a.real * b.real - a.imag * b.imag
    imag := a.real * b.imag + a.imag * b.real
    return Complex(real, imag)
}

ComplexAdd(a, b)
{
    If !(a is Complex) || !(b is Complex)
        throw ValueError("Complex numbers can only be added to Complex numbers. Here: Type(a=" a ") = " Type(a) ", Type(b=" b ") = " Type(b))
    
    real := a.real + b.real
    imag := a.imag + b.imag
    return Complex(real, imag)
}