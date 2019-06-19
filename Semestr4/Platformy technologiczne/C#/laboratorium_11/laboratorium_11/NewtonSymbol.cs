using System;
using System.Threading.Tasks;

namespace laboratorium_11
{
    class NewtonSymbol
    {
        public int K { get; set; }
        public int N { get; set; }


        public NewtonSymbol(int n, int k)
        {
            N = n;
            K = k;
        }

        public double CalculateTasks()
        {
            if (N <= 0 || K <= 0) return -1;
            if (N < K) return -2;

            Task<double> counterTask = Task.Factory.StartNew(
                (obj) => CalculateCounter(),
                100 //state
                );

            Task<double> denominatorTask = Task.Factory.StartNew(
                (obj) => CalculateDenominator(),
                100 //state
                );

            counterTask.Wait();
            denominatorTask.Wait();
            return counterTask.Result / denominatorTask.Result;
        }

        public double CalculateDelegates()
        {
            if (N <= 0 || K <= 0) return -1;
            if (N < K) return -2;

            Func<double> counterFunc = CalculateCounter;
            Func<double> denominatorFunc = CalculateDenominator;

            var counter = counterFunc.BeginInvoke(null, null);
            var denominator = denominatorFunc.BeginInvoke(null, null);
            while (!counter.IsCompleted && !denominator.IsCompleted)
            {
            }

            return counterFunc.EndInvoke(counter) / denominatorFunc.EndInvoke(denominator);
        }


        public async Task<double> CalculateAsyncAwait()
        {
            var counter = Task.Run(CalculateCounter);
            var denominator =Task.Run(CalculateDenominator);

            await Task.WhenAll(counter, denominator);

            return counter.Result / denominator.Result;
        }



        private double CalculateCounter()
        {
            double returnValue = 1;
            for (int i = (N - K + 1); i <= N; i++)
            {
                returnValue *= i;
            }
            return returnValue;
        }
        private double CalculateDenominator()
        {
            double returnValue = 1;
            for (int i = 1; i <= K; i++)
            {
                returnValue *= i;
            }
            return returnValue;
        }

    }
}
