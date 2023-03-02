<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sportsManagerLogin.aspx.cs" Inherits="milestone3.sportsManagerLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <div>
            Sports Association Manager Register<br />
            <br />
            Name<br />
            <asp:TextBox ID="nameSAP" runat="server" OnTextChanged="nameSAP_TextChanged"></asp:TextBox>
            <br />
            Username<br />
            <asp:TextBox ID="usernameSAP" runat="server" OnTextChanged="username_TextChanged"></asp:TextBox>
            <br />
            Password<br />
            <asp:TextBox ID="passwordSAP" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="registerSAP" runat="server" Text="Register" OnClick="register_Click" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
