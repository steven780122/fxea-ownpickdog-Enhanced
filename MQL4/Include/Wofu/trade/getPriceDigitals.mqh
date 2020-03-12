int getPriceDigitals(   string fSymbol )
{
   return (int)SymbolInfoInteger(fSymbol, SYMBOL_DIGITS);
}