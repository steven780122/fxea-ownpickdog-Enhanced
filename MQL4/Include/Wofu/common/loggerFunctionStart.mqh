#include <Wofu\\common\\logger.mqh>
void loggerFunctionStart(string FunctionId)
{
   logger(LOG_INFO,FunctionId+" Start");
}