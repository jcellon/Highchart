using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    //public WebService () {

    //    //Uncomment the following line if using designed components 
    //    //InitializeComponent(); 
    //}

    public class cityPopulation
    {
        public string city_name { get; set; }
        public int population { get; set; }
        public string id { get; set; }
    }

    [WebMethod]
    public List<cityPopulation> getCityPopulation(List<string> pData)
    {
        List<cityPopulation> p = new List<cityPopulation>();
        using (SqlConnection cn = new SqlConnection(@"Data Source=ELLON;Initial Catalog=StatePopulation;Integrated Security=True")) //LenoDb
        {
            string myQuery = "SELECT id_, city_name, population FROM [StatePopulation].[dbo].[StatePopulation$] WHERE year_of = @year"; //LenoDb     
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = myQuery;
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@year", pData[0]);
            cmd.Connection = cn;
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    cityPopulation cpData = new cityPopulation();
                    cpData.city_name = dr["city_name"].ToString();
                    cpData.population = Convert.ToInt32(dr["population"].ToString());
                    p.Add(cpData);
                }
            }
        }
        return p;
    }
    
}
