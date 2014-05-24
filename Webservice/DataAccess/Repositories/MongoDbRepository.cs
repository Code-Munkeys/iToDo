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
using System.Configuration;
using System.Diagnostics;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using MongoDB.Driver;
using MongoDB.Driver.Builders;
using MongoDB.Driver.Linq;

/// <summary>
/// A MongoDB repository. Maps to a collection with the same name
/// as type TEntity.
/// </summary>
/// <typeparam name="T">Entity type for this repository</typeparam>

public class MongoDbRepository<TEntity> : 
    IRepository<TEntity> where 
        TEntity : EntityBase
{
    private MongoDatabase database;
    private MongoCollection<TEntity> collection;

    public MongoDbRepository()
    {
        GetDatabase();
        GetCollection();
    }

    public bool Insert(TEntity entity)
    {
        entity.Id = Guid.NewGuid();
        return collection.Insert(entity).Ok;
    }

    public bool Update(TEntity entity)
    {
        if (entity.Id == null)
            return Insert(entity);
        
        return collection
            .Save(entity)
                .DocumentsAffected > 0;
    }

    public bool Delete(TEntity entity)
    {
        return collection
            .Remove(Query.EQ("_id", entity.Id))
                .DocumentsAffected > 0;
    }

    public IList<TEntity> 
        SearchFor(Expression<Func<TEntity, bool>> predicate)
    {
        return collection
            .AsQueryable<TEntity>()
                .Where(predicate.Compile())
                    .ToList();
    }

    public IList<TEntity> GetAll()
    {
        return collection.FindAllAs<TEntity>().ToList();
    }

    public TEntity GetById(Guid id)
    {
        return collection.FindOneByIdAs<TEntity>(id);
    }

    public IList<TEntity> GetByUuid(String UniqueUserId)
    {
        var query = Query.EQ("Uuid", UniqueUserId);
        var job = collection.FindOne(query);
        var allJobsByUuid = collection.Find(Query.EQ("Uuid", UniqueUserId)).ToList();
        //var jobLast = collection.Find(Query.EQ("Uuid", UniqueUserId)).Last();
        return allJobsByUuid;
    }

    #region Private Helper Methods
    private void GetDatabase()
    {
        var client = new MongoClient(GetConnectionString());
        var server = client.GetServer();

        database = server.GetDatabase(GetDatabaseName());
    }

    private string GetConnectionString()
    {
        return WebConfigurationManager
            .AppSettings
                .Get("MongoDbConnectionString")
                    .Replace("{DB_NAME}", GetDatabaseName());
    }

    private string GetDatabaseName()
    {
        return WebConfigurationManager
            .AppSettings
                .Get("MongoDbDatabaseName");
    }

    public void GetCollection()
    {
        collection = database
            .GetCollection<TEntity>(typeof(TEntity).Name);
    }
    #endregion
}