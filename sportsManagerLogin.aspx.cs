using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3
{
    public partial class sportsManagerLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void username_TextChanged(object sender, EventArgs e)
        {

        }

        protected void password_TextChanged(object sender, EventArgs e)
        {

        }

        protected void nameSAP_TextChanged(object sender, EventArgs e)
        {

        }

        protected void register_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = nameSAP.Text;
            String userName = usernameSAP.Text;
            String passWord = passwordSAP.Text;
            conn.Open();

            SqlCommand checkUsername = new SqlCommand("checkUsername", conn);
            checkUsername.CommandType = CommandType.StoredProcedure;
            checkUsername.Parameters.Add(new SqlParameter("@username", userName));
            SqlParameter checkBit = checkUsername.Parameters.Add("@check", SqlDbType.Int);
            checkBit.Direction = ParameterDirection.Output;
            checkUsername.ExecuteNonQuery();

            if (checkBit.Value.ToString()=="1") {
                Response.Write("username already in use, try logging in");
                
            }
            else {
                SqlCommand addAssociationManager = new SqlCommand("addAssociationManager", conn);
                addAssociationManager.CommandType = CommandType.StoredProcedure;
                addAssociationManager.Parameters.Add(new SqlParameter("@name", name));
                addAssociationManager.Parameters.Add(new SqlParameter("@username", userName));
                addAssociationManager.Parameters.Add(new SqlParameter("@password", passWord));
                addAssociationManager.ExecuteNonQuery();
                Response.Redirect("sportsManagerPage.aspx");

            }

            conn.Close();

        }

        

        
    }
}