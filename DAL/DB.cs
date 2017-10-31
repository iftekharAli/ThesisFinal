using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Configuration;
namespace DAL
{
    public class Db
    {

        private readonly string _con;

        public Db()
        {
            _con = ConfigurationManager.ConnectionStrings["Con"].ConnectionString;
        }
        public int ExecuteNonQuery(string query)
        {

            return ExecuteQuery(query, new List<SqlParameter>());


        }
        public int ExecuteNonQuery(string query, List<SqlParameter> parmList)
        {
            return ExecuteQuery(query, parmList);
        }

        public DataSet GetDataSet(string query, List<SqlParameter> parmList)
        {
            return GetDataset(query, parmList);
        }
        public DataSet GetDataSet(string query)
        {
            return GetDataset(query, new List<SqlParameter>());
        }

        public string GetSingelValue(string commandText, List<SqlParameter> parameters)
        {
            return GetScallervalue( commandText,  parameters);
        }
        public string GetSingelValue(string commandText)
        {
            return GetScallervalue( commandText, new List<SqlParameter>());
        }



        private string GetScallervalue(string commandText, List<SqlParameter> parameters)
        {

            string result=string.Empty;
            using (SqlConnection connection = new SqlConnection(_con))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = commandText;


                    if (parameters.Any())
                    {
                        foreach (SqlParameter sqlParameter in parameters)
                        {
                            command.Parameters.AddWithValue(sqlParameter.ParameterName, sqlParameter.Value ?? DBNull.Value);
                        }
                        command.CommandType = CommandType.StoredProcedure;
                    }

                    try
                    {
                        connection.Open();
                        var executeScalar = command.ExecuteScalar();
                        if (executeScalar != null)
                            result = executeScalar.ToString();

                    }
                    catch (Exception e)
                    {
                        throw new Exception(e.Message);
                    }

                }

            }
            return result;
        }
        private DataSet GetDataset(string commandText, List<SqlParameter> parameters)
        {

            DataSet ds = new DataSet();
           
            using (SqlConnection connection = new SqlConnection(_con))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = commandText;


                    if (parameters.Any())
                    {
                        foreach (SqlParameter sqlParameter in parameters)
                        {
                            command.Parameters.AddWithValue(sqlParameter.ParameterName, sqlParameter.Value ?? DBNull.Value);
                        }
                        command.CommandType = CommandType.StoredProcedure;
                    }

                    try
                    {
                        connection.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        adapter.Fill(ds);


                    }
                    catch (Exception e)
                    {
                        throw new Exception(e.Message);
                    }

                }

            }
            return ds;
        }

        private int ExecuteQuery(string commandText, List<SqlParameter> parameters)
        {
            int result = 0;
            using (SqlConnection connection = new SqlConnection(_con))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = commandText;
                    if (parameters.Any())
                    {
                        foreach (SqlParameter sqlParameter in parameters)
                        {
                            command.Parameters.AddWithValue(sqlParameter.ParameterName, sqlParameter.Value ?? DBNull.Value);
                        }
                        command.CommandType = CommandType.StoredProcedure;
                    }

                    try
                    {
                        connection.Open();
                        result = command.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        throw new Exception(e.Message);
                    }

                }

            }
            return result;
        }


    }
}
