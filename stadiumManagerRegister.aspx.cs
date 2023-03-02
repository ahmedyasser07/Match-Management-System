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
    public partial class stadiumManagerLogin : System.Web.UI.Page
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

        protected void login_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["project"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            String name = TextBox1.Text;
            String userName = usernameSM.Text;
            String passWord = passwordSM.Text;
            String stad = TextBox2.Text;
            conn.Open();

            //check0=1 if username is already used
            //check1=0 if stadium not in system
            //check2=1 if stadium has a mngr

            SqlCommand checkUsername = new SqlCommand("checkUsername", conn);
            checkUsername.CommandType = CommandType.StoredProcedure;
            checkUsername.Parameters.Add(new SqlParameter("@username", userName));
            SqlParameter check0 = checkUsername.Parameters.Add("@check", SqlDbType.Int);
            check0.Direction = ParameterDirection.Output;
            checkUsername.ExecuteNonQuery();

            SqlCommand checkIfStadiumInSystem = new SqlCommand("checkIfStadiumInSystem", conn);
            checkIfStadiumInSystem.CommandType = CommandType.StoredProcedure;
            checkIfStadiumInSystem.Parameters.Add(new SqlParameter("@stadiumname", stad));
            SqlParameter check1 = checkIfStadiumInSystem.Parameters.Add("@check", SqlDbType.Int);
            check1.Direction = ParameterDirection.Output;
            checkIfStadiumInSystem.ExecuteNonQuery();


            SqlCommand checkIfStadHasMNG = new SqlCommand("checkIfStadHasMNG", conn);
            checkIfStadHasMNG.CommandType = CommandType.StoredProcedure;
            checkIfStadHasMNG.Parameters.Add(new SqlParameter("@stadium", stad));
            SqlParameter check2 = checkIfStadHasMNG.Parameters.Add("@check", SqlDbType.Int);
            check2.Direction = ParameterDirection.Output;
            checkIfStadHasMNG.ExecuteNonQuery();


            if (check0.Value.ToString() == "1")
            {
                Response.Write("username already in use");
            }
            else
            {

                if (check1.Value.ToString() == "0")
                {
                    Response.Write("stadium does not exist");
                }
                else
                {
                    if (check2.Value.ToString() == "1")
                    {
                        Response.Write("stadium already has a manager");
                    }
                    else
                    {
                        SqlCommand addStadiumManager = new SqlCommand("addStadiumManager", conn);
                        addStadiumManager.CommandType = CommandType.StoredProcedure;
                        addStadiumManager.Parameters.Add(new SqlParameter("@name", name));
                        addStadiumManager.Parameters.Add(new SqlParameter("@stadium", stad));
                        addStadiumManager.Parameters.Add(new SqlParameter("@username", userName));
                        addStadiumManager.Parameters.Add(new SqlParameter("@pass", passWord));
                        addStadiumManager.ExecuteNonQuery();
                        Response.Redirect("stadiumManagerPage.aspx?userName="+userName);
                    }
                }
            }

            conn.Close();
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }
    }
}