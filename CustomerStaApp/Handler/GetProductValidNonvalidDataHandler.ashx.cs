using System;
using DAL;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI.WebControls;

namespace CustomerStaApp.Handler
{
    /// <summary>
    /// Summary description for GetProductValidNonvalidDataHandler
    /// </summary>
    public class GetProductValidNonvalidDataHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string Recency = context.Request.QueryString["Recency"];
            string Frequency = context.Request.QueryString["Frequency"];
            string Monetary = context.Request.QueryString["Monetary"];
            string DataType = context.Request.QueryString["DataType"];
            string Rating = context.Request.QueryString["Rating"];


            string json = new StreamReader(context.Request.InputStream).ReadToEnd();
            json = json.Replace("[", string.Empty).Replace("]", string.Empty).Replace("\"", string.Empty);
            json = HttpUtility.HtmlDecode(json);
            Db db = new Db();

            List<SqlParameter> list = new List<SqlParameter>
            {
                new SqlParameter
                {
                    ParameterName = "@Recency",
                    Value = Recency
                },
                new SqlParameter
                {
                    ParameterName = "@Frequency",
                    Value = Frequency
                },
                new SqlParameter
                {
                    ParameterName = "@Monetary",
                    Value = Monetary
                }
                ,new SqlParameter
                {
                    ParameterName="@Title",
                    Value = json.Replace("[",string.Empty).Replace("]",string.Empty).Replace("\"",string.Empty)
                },
                new SqlParameter
                {
                    ParameterName="@DataType",
                    Value = DataType
                }, new SqlParameter
                {
                    ParameterName="@Rating",
                    Value = Rating
                }

            };
            DataSet dataSet = null;


            dataSet = db.GetDataSet("spGetProductValidNonvalidData", list);


            string valid = string.Empty;
            string nonvalid = string.Empty;
            string prior = string.Empty;

            valid = DataTableToJsonWithJsonNet(dataSet.Tables[0]); ;
            nonvalid = DataTableToJsonWithJsonNet(dataSet.Tables[1]); ;
            prior = DataTableToJsonWithJsonNet(dataSet.Tables[2]);
            List<Product> productListMain = dataSet.Tables[2].AsEnumerable().Select(dataRow => new Product { Name = dataRow.Field<string>("Product Name") }).ToList();
            Dictionary<string, int> dicFrequentpatternOne = new Dictionary<string, int>();

            foreach (DataRow dr in dataSet.Tables[2].Rows)
            {

                string productName = dr["Product Name"].ToString();
                string[] vv = productName.Split(',');
                foreach (var productList in vv)
                {
                    if (dicFrequentpatternOne.ContainsKey(productList))
                    {
                        int value2 = (int)dicFrequentpatternOne[productList];
                        dicFrequentpatternOne[productList] = ++value2;
                    }
                    else
                    {
                        dicFrequentpatternOne.Add(productList, 1);

                    }

                }
            }



            Dictionary<string, int> dicFrequentpattern = new Dictionary<string, int>();
            Dictionary<string, int> copydicFrequentpatternOne = new Dictionary<string, int>(dicFrequentpatternOne);
            Dictionary<string, int> afterMinimum = new Dictionary<string, int>();

            var priorData = PriorLogic(dicFrequentpatternOne, dicFrequentpattern, productListMain, afterMinimum);
            IEnumerable<KeyValuePair<string, double>> PriorResult = new List<KeyValuePair<string, double>>();
            List<FinalList> flist = new List<FinalList>();
            int count = priorData.Count();
            foreach (var priorDataKey in priorData.Keys)
            {
                var rawToScan = string.Join(",", priorDataKey.Split(',').Distinct());
                var a = productListMain.Where(o => o.Name.ToString().Contains(rawToScan))
                    .ToList();
                var ee = productListMain.Where(x => priorDataKey.Split(',').All(x.Name.Contains)).ToList();
                int globalValueToDivide = a.Count;
                var segmentWise= priorDataKey.Split(',').Distinct();
                string[] intInput = priorDataKey.Split(',').Distinct().ToArray();
                int renewLength = intInput.Length;
                var arraytoList = intInput.ToList();
               
                for (int i = intInput.Length - 1; i > 1; i--)
                {
                    IEnumerable<IEnumerable<string>> permutationsWithRept = GetPermutations<string>(arraytoList, i);
                    var flistAFinalLists = PermutationToResultSet(permutationsWithRept, arraytoList);

                    //List<string> list = new List<string> { "A,B", "A,B,C", "B,D,A", "B,D", "A,K,C,E,B" };


                    //List<string> list2 = new List<string> { "A,B", "B,C", "A" };

                    Dictionary<string, double> dictionary = new Dictionary<string, double>();
                    double value = 0;
                    foreach (var val in flistAFinalLists)
                    {
                        string[] strings = val.Right.Split(',');
                        var aa = productListMain.Where(x => strings.All(x.Name.Contains)).ToList();
                        value = (double)globalValueToDivide/(double)(aa.Count);
                        value = value * 100;
                        dictionary.Add(val.Left+ " => "+ val.Right, value);
                    }

                     PriorResult = dictionary.Where(x => x.Value > 30);


                }

            }


          
            var jsonPriorAlgorithData = JsonConvert.SerializeObject(PriorResult.ToList());
            string resjson = "{\"valid\":" + valid + ",\"nonvalid\":" + nonvalid + ",\"prior\":" + jsonPriorAlgorithData + "}";

            context.Response.Write(resjson);

        }
        static IEnumerable<IEnumerable<T>> GetPermutations<T>(IEnumerable<T> items, int count)
        {
            int i = 0;
            foreach (var item in items)
            {
                if (count == 1)
                    yield return new T[] { item };
                else
                {
                    foreach (var result in GetPermutations(items.Skip(i + 1), count - 1))
                        yield return new T[] { item }.Concat(result);
                }

                ++i;
            }
        }
        private static List<FinalList> PermutationToResultSet(IEnumerable<IEnumerable<string>> permutationsWithRept, List<string> arraytoList)
        {
            List<string> tempList = new List<string>();

            List<FinalList> finaList= new List<FinalList>();
            string result = string.Empty;
            string exceptString = string.Empty;
            foreach (IEnumerable<string> enumerable in permutationsWithRept)
            {
                tempList = new List<string>();
                foreach (var i in enumerable)
                {
                    tempList.Add(i);
                }
                var except = arraytoList.Except(tempList);

                result = tempList.Aggregate<string>((i, j) => i + "," + j);
                exceptString = except.Aggregate((i, j) => i + "," + j);
                Console.WriteLine(result + "=>" + exceptString);
                finaList.Add(new FinalList()
                {
                    Left = result,
                    Right = exceptString
                });
            }

            if (arraytoList.Count - 1 == tempList.Count)
            {


                foreach (IEnumerable<string> enumerable in permutationsWithRept)
                {
                    tempList = new List<string>();
                    foreach (var i in enumerable)
                    {
                        tempList.Add(i);
                    }
                    var except = arraytoList.Except(tempList);

                    result = tempList.Aggregate<string>((i, j) => i + "," + j);
                    exceptString = except.Aggregate((i, j) => i + "," + j);
                    //Console.WriteLine(exceptString + "=>" + result);
                    finaList.Add(new FinalList()
                    {
                        Left = exceptString,
                        Right = result 
                    });
                }
            }

            return finaList;

        }
        public class FinalList
        {
            public string Left { get; set; }
            public string Right { get; set; }
        }
        private static Dictionary<string, int> PriorLogic(Dictionary<string, int> dicFrequentpatternOne, Dictionary<string, int> dicFrequentpattern, List<Product> empList,
            Dictionary<string, int> afterMinimum)
        {
            int total = 0;
            DictionaryKeyValueAdd(dicFrequentpatternOne, dicFrequentpattern, empList, total);
            DictionaryKeyValueAdd(dicFrequentpatternOne, dicFrequentpattern, empList, total);
            Dictionary<string, int> copyFrequentPattern = new Dictionary<string, int>(dicFrequentpattern);

            foreach (var rawVal in dicFrequentpattern)
            {
                if (rawVal.Value >= 1)
                {
                    afterMinimum.Add(rawVal.Key, rawVal.Value);
                }
            }
            Dictionary<string, int> copyMinimumPattern = new Dictionary<string, int>(afterMinimum);
            if (afterMinimum.Count > 0)
            {
                afterMinimum.Clear();
                dicFrequentpattern.Clear();
                return PriorLogic(copyMinimumPattern, dicFrequentpattern, empList, afterMinimum);

            }
            else if (afterMinimum.Count == 0)
            {
                Dictionary<string, int> final = new Dictionary<string, int>(dicFrequentpatternOne);
                return final;

            }

            Dictionary<string, int> final1 = new Dictionary<string, int>(dicFrequentpatternOne);
            return final1;
        }
      
        private static int DictionaryKeyValueAdd(Dictionary<string, int> dicFrequentpatternOne, Dictionary<string, int> hashFrequentpatternTwo, List<Product> proList, int total)
        {
            for (int i = 0; i < dicFrequentpatternOne.Count; i++)
            {

                for (int j = i + 1; j < dicFrequentpatternOne.Count; j++)
                {
                    if (hashFrequentpatternTwo.ContainsKey(dicFrequentpatternOne.Keys.ElementAt(i) + "," +
                                                           dicFrequentpatternOne.Keys.ElementAt(j)))
                    {
                        var a = proList.Where(o => o.Name.ToString().Contains(dicFrequentpatternOne.Keys.ElementAt(i)))
                            .ToList()
                            .Where(o => o.Name.ToString()
                                .Contains(dicFrequentpatternOne.Keys.ElementAt(j))).ToList();
                        if (a.Count > 0)
                        {
                            total = total + 1;
                        }
                        if (total > 0)
                        {
                            int value2 = (int) hashFrequentpatternTwo[dicFrequentpatternOne.Keys.ElementAt(i) + "," +
                                                                      dicFrequentpatternOne.Keys.ElementAt(j)];
                            if (value2 != 0)
                            {
                                value2 += a.Count;
                            }
                            else
                            {
                                value2 = a.Count;
                            }
                            hashFrequentpatternTwo[dicFrequentpatternOne.Keys.ElementAt(i) + "," +
                                                   dicFrequentpatternOne.Keys.ElementAt(j)] = value2;
                        }
                    }
                    else
                    {
                        hashFrequentpatternTwo.Add(
                            dicFrequentpatternOne.Keys.ElementAt(i) + "," + dicFrequentpatternOne.Keys.ElementAt(j), 0);
                    }

                   

                }
            }
            return total;
        }
        public string DataTableToJsonWithJsonNet(DataTable table)
        {
            var jsonString = JsonConvert.SerializeObject(table);
            return jsonString;
        }
        public class Product
        {
            public string Name { get; set; }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}