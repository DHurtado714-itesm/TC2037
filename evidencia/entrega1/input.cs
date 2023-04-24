using System;

namespace MyNamespace
{
    class Program
    {
        static void Main(string[] args)
        {
            // This is a single-line comment

            /*
            This is a multi-line comment
            */

            string myString = "Hello, world!";
            int myInt = 42;
            float myFloat = 3.14;

            if (myInt == 42 && myFloat < 4.0)
            {
                Console.WriteLine(myString);
            }

            for (int i = 0; i < 10; i++)
            {
                Console.WriteLine("i = " + i);
            }

            int[] myArray = { 1, 2, 3, 4, 5 };

            foreach (int value in myArray)
            {
                Console.WriteLine("Value: " + value);
            }

            switch (myInt)
            {
                case 1:
                    Console.WriteLine("The value is 1.");
                    break;
                case 2:
                    Console.WriteLine("The value is 2.");
                    break;
                default:
                    Console.WriteLine("The value is something else.");
                    break;
            }

            while (myInt > 0)
            {
                Console.WriteLine("myInt = " + myInt);
                myInt--;
            }

            do
            {
                Console.WriteLine("This will be printed at least once.");
            } while (false);

            int result = AddNumbers(2, 3);
            Console.WriteLine("The result is " + result);

            Console.ReadLine();
        }

        static int AddNumbers(int a, int b)
        {
            int result = a + b;
            return result;
        }
    }
}
