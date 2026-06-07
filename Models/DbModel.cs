using System.Data;
using System.Data.SqlClient;
using ProleBlog.Config;
using System.Linq;

namespace ProleBlog.Models;

public static class DbModel {
    private static SqlConnection conn = new SqlConnection(Config.ConnectString);

    public static void Open() => conn.Open();
    public static void Close() => conn.Close();

    public static DataTable Select(string query) {
        DataTable result = new DataTable();

        SqlDataAdapter command = new SqlDataAdapter(query, conn);

        command.Fill(command);
        

    }

}