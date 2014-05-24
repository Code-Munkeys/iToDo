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
using System.Net;
using System.Net.Http;
using System.Web.Http;

//http://code.msdn.microsoft.com/Using-MongoDB-with-ASPNET-309ac74b

//http://localhost:1049/api/todo?Uuid=FA507E77-D86D-46FE-885F-A2E4E48266E4
//http://localhost:1049/api/todo/FA507E77-D86D-46FE-885F-A2E4E48266E4

//http://docs.mongodb.org/manual/reference/method/db.collection.find/

//db.ToDo.find( { Uuid : "390A07F0-4C5F-4ED2-A60C-A9A7B4C402CD" } )
//db.ToDo.find( { Uuid : "390A07F0-4C5F-4ED2-A60C-A9A7B4C402CD" } && { Status : "Completed" } )
//https://secure.webapiservice.com/todowebservice/api/todo?uuid=3A2EAE6C-EA80-4E48-88EA-FD6DA5D433BB

namespace Webservice.Controllers
{
    public class ToDoController : ApiController
    {
        // GET api/todo
        IRepository<ToDo> todoRepository;

        public ToDoController()
        {
            todoRepository = new MongoDbRepository<ToDo>();
        }

        public IEnumerable<ToDo> GetTodo()
        {
            var arr = todoRepository.GetAll().ToArray();
            return arr;
        }

        // GET api/todo/5
        //public ToDo Get(string id)
        //{
        //    Guid guid;
        //    Guid.TryParse(id, out guid);
        //    var todo = todoRepository.GetById(guid);
        //    return todo;
        //}

        // GET api/todo/390A07F0-4C5F-4ED2-A60C-A9A7B4C402CD
        public IEnumerable<ToDo> GetTodo(string id)
        {
            var todo = todoRepository.GetByUuid(id);
            return todo;
        }

        // POST api/todo
        public HttpResponseMessage Post(ToDo todo)
        {
            var result = todoRepository.Insert(todo);
            var response = Request.CreateResponse<ToDo>(HttpStatusCode.Created, todo);
            return response;
        }

        // PUT api/todo/5
        public ToDo Put(ToDo todo, string id)
        {
            Guid guid;
            Guid.TryParse(id, out guid);

            if (todo != null && todo.Id != null)
                todo.Id = guid;

            var result = todoRepository.Update(todo);
            return todo;
        }

        // DELETE api/todo/5
        public void Delete(string id)
        {
            Guid guid;
            Guid.TryParse(id, out guid);
            bool result = false;

            var todo = todoRepository.GetById(guid);

            if (todo == null)
                throw new HttpResponseException(HttpStatusCode.NotFound);
            else
                result = todoRepository.Delete(todo);
        }
    }
}