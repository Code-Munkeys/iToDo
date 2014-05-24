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

public class Task : EntityBase
{
    public string Title { get; set; }
    public string Description { get; set; }
    public string Uuid { get; set; }
    public string AssignedDate { get; set; }
    public string EstimatedDate { get; set; }
    public string CompletedDate { get; set; }
    public string Status { get; set; }
    public string Image { get; set; }
    public string Signature { get; set; }
}
