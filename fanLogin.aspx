<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fanLogin.aspx.cs" Inherits="milestone3.fanLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div>
            Fan Register<br />
             <br />
             Name<br />
             <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged" style="height: 22px"></asp:TextBox>
            <br />
            Username<br />
            <asp:TextBox ID="usernameF" runat="server" OnTextChanged="username_TextChanged"></asp:TextBox>
            <br />
            Password<br />
            <asp:TextBox ID="passwordF" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
             <br />
             National ID Number<br />
             <asp:TextBox ID="TextBox2"  type='number' runat="server" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
             <br />
             Phone<br />
             <asp:TextBox ID="TextBox3"  type='number' runat="server" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
             <br />
             BirthDate<br />
             <asp:TextBox ID="TextBox4" type="datetime-local" runat="server" OnTextChanged="TextBox4_TextChanged"></asp:TextBox>
             <br />
             Address<br />
             <asp:TextBox ID="TextBox5" runat="server" OnTextChanged="TextBox5_TextChanged"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="loginF" runat="server" Text="Register" OnClick="login_Click" />
        </div>
    </form>
</body>
</html>
