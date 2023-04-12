using System;
using System.Collections.Generic;

namespace Example
{
    public class Program
    {
        public static void Main(string[] args)
        {
            List<int> numbers = new List<int> { 1, 2, 3, 4, 5 };
            int sum = Sum(numbers);
            Console.WriteLine("The sum of the numbers is: " + sum);
        }

        public static int Sum(List<int> numbers)
        {
            int result = 0;
            foreach (int number in numbers)
            {
                result += number;
            }
            return result;
        }
    }
}
