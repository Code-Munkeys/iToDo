/*
Developed by Franz Ayestaran on 10/2/14.
Copyright (c) 2014 Zonk Technology. All rights reserved.
 
You may use this code in your own projects and upon doing so, you the programmer are solely
responsible for determining it's worthiness for any given application or task. Here clearly
states that the code is for learning purposes only and is not guaranteed to conform to any
programming style, standard, or be an adequate answer for any given problem.
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MongoDBTest
{
    class Program
    {
        static void Main(string[] args)
        {
            TestToDoOperations();

            Console.Write("Test Completed! Press any key to continue...");
            Console.ReadKey();
        }

        private static void TestToDoOperations()
        {

            var job1 = new ToDo()
            {
                Title = "iTracker on App Store",
                Description = "A GPS based telemetry logger that stores real-time location data at user defined intervals. Journey information can be displayed on an interactive map or through the built-in CSV and GPX viewer. Routes exported via email can be imported into third party software that support both Comma-separated and GPS eXchange file formats. Waypoints can be graphically or manually bookmarked, then imported and exported via the clipboard.",
                Uuid = "FA507E77-D86D-46FE-885F-A2E4E48266E4",
                AssignedDate = "16/10/13",
                EstimatedDate = "01/11/13",
                CompletedDate = "03/12/2013",
                Status = "Ready for Sale",
                Image = "",
                Signature = "iPhone"
            };

            var job1b = new ToDo()
            {
                Title = "iTracker on App Store",
                Description = "A GPS based telemetry logger that stores real-time location data at user defined intervals. Journey information can be displayed on an interactive map or through the built-in CSV and GPX viewer. Routes exported via email can be imported into third party software that support both Comma-separated and GPS eXchange file formats. Waypoints can be graphically or manually bookmarked, then imported and exported via the clipboard.",
                Uuid = "DFD00AD7-BD17-4528-B6AD-DBBC44AE7FC9",
                AssignedDate = "16/10/13",
                EstimatedDate = "01/11/13",
                CompletedDate = "03/12/2013",
                Status = "Ready for Sale",
                Image = "",
                Signature = "iOS Simulator"
            };

            var job2 = new ToDo()
            {
                Title = "iWebsearch on App Store",
                Description = "Designed to speed up the process required when submitting a single search term to multiple search engines. By simply tapping on the desired search engine the user can scroll through the list then repeat the process by navigating back and tapping an alternative search engine. Bookmarked results can be viewed then exported via email in a Comma-separated format.",
                Uuid = "FA507E77-D86D-46FE-885F-A2E4E48266E4",
                AssignedDate = "03/12/2013",
                EstimatedDate = "06/12/2013",
                CompletedDate = "12/12/2013",
                Status = "Ready for Sale",
                Image = "",
                Signature = "iPhone"
            };

            var job2b = new ToDo()
            {
                Title = "iWebsearch on App Store",
                Description = "Designed to speed up the process required when submitting a single search term to multiple search engines. By simply tapping on the desired search engine the user can scroll through the list then repeat the process by navigating back and tapping an alternative search engine. Bookmarked results can be viewed then exported via email in a Comma-separated format.",
                Uuid = "DFD00AD7-BD17-4528-B6AD-DBBC44AE7FC9",
                AssignedDate = "03/12/2013",
                EstimatedDate = "06/12/2013",
                CompletedDate = "-",
                Status = "In Review",
                Image = "",
                Signature = "iOS Simulator"
            };

            var jobRepository = new MongoDbRepository<ToDo>();

            Console.WriteLine("Inserting job1 for iPhone");
            var insertResult1 = jobRepository.Insert(job1);

            Console.WriteLine("Inserting job1b for iOS Simulator");
            var insertResult3 = jobRepository.Insert(job1b);

            Console.WriteLine("Inserting job2 for iPhone");
            var insertResult2 = jobRepository.Insert(job2);

            Console.WriteLine("Inserting job2b for iOS Simulator");
            var insertResult4 = jobRepository.Insert(job2b);

            Console.WriteLine("Updating job2B status");
            job2b.Status = "Ready for Sale";
            var updateResult = jobRepository.Update(job2b);

            Console.WriteLine("Updating job2B completed date");
            job2b.CompletedDate = "12/12/2013";
            var updateResult2 = jobRepository.Update(job2b);

            Console.WriteLine("Searching jobs for 'In Review' Status");
            var searchResult = jobRepository.SearchFor(c => c.Status == "Ready for Sale");

            Console.WriteLine("Get all jobs");
            var getAllResult = jobRepository.GetAll();

            Console.WriteLine("Getting job by id");
            var getByIdResult = jobRepository.GetById(job1.Id);

            //Console.WriteLine("Deleting job");
            //var deleteResult = jobRepository.Delete(job2b);
        }

    }
}
