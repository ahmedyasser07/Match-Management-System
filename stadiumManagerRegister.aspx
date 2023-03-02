<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="stadiumManagerRegister.aspx.cs" Inherits="milestone3.stadiumManagerLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Stadium ManagerRegister<br />
            <br />
            Name<br />
            <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            <br />
            Username<br />
            <asp:TextBox ID="usernameSM" runat="server" OnTextChanged="username_TextChanged"></asp:TextBox>
            <br />
            Password<br />
            <asp:TextBox ID="passwordSM" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            Stadium<br />
            <asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="loginSM" runat="server" Text="Register" OnClick="login_Click" />
        </div>
    </form>
</body>
</html>
