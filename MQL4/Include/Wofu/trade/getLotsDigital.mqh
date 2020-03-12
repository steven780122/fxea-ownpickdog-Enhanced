int getLotsDigital(string fSymbol) export
{
        if (SymbolInfoDouble(fSymbol, SYMBOL_VOLUME_MIN) >= 0.01) return(2);
   else if (SymbolInfoDouble(fSymbol, SYMBOL_VOLUME_MIN) >= 0.1 ) return(1);
   return(0);
}