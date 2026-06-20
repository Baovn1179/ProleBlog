using System.Data;
using System.Data.SqlClient;
using System.Linq;
using ProleBlog.Config;

namespace ProleBlog.Util;

public static class DbUtil {
    private static SqlConnection conn = new SqlConnection(AppConfig.ConnectString);

    public static void Open() => conn.Open();
    public static void Close() => conn.Close();

    public static DataTable Select(string query) {
        DataTable result = new DataTable();

        SqlDataAdapter command = new SqlDataAdapter(query, conn);

        command.Fill(result);

        return result;
    }

    public static bool Execute(string query) {
        SqlCommand command = new SqlCommand(query, conn);
        
        return command.ExecuteNonQuery() > 1;
    }

}