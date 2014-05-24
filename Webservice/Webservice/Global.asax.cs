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
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace Webservice
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}