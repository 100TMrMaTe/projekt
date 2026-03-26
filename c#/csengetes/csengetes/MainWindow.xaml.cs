using MySql.Data.MySqlClient;
using System.Data;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;

namespace csengetes
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            Toggle(dot1, btn1);
        }

        private MySqlDataAdapter adapterNormal;
        private MySqlDataAdapter adapterRendkivuli;
        private MySqlDataAdapter adapterRöviditett;
        private DataTable dtNormal;
        private DataTable dtRendkivuli;
        private DataTable dtRöviditett;

        private string connectionString = "Server=localhost;Database=projekt;User=root;Password=;";

        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var tab = sender as TabControl;
            if (tab == null) return;

            if (tab.SelectedIndex == 1 && dtNormal == null)
            {
                MySqlConnection con = new MySqlConnection(connectionString);
                adapterNormal = new MySqlDataAdapter("SELECT c.oraszam, jelzo.idopont AS jelzo, becsengetes.idopont AS becsengetes, kicsengetes.idopont AS kicsengetes FROM csengetes c, orak jelzo, orak becsengetes, orak kicsengetes WHERE c.nap_id = 1 AND c.jelzo_id = jelzo.id AND c.becsengetes_id = becsengetes.id AND c.kicsengetes_id = kicsengetes.id ORDER BY c.oraszam", con);
                new MySqlCommandBuilder(adapterNormal);
                dtNormal = new DataTable();
                adapterNormal.Fill(dtNormal);
                datagridNormal.ItemsSource = dtNormal.DefaultView;
            }
            else if (tab.SelectedIndex == 2 && dtRöviditett == null)
            {
                MySqlConnection con = new MySqlConnection(connectionString);
                adapterRöviditett = new MySqlDataAdapter("SELECT c.oraszam, jelzo.idopont AS jelzo, becsengetes.idopont AS becsengetes, kicsengetes.idopont AS kicsengetes FROM csengetes c, orak jelzo, orak becsengetes, orak kicsengetes WHERE c.nap_id = 2 AND c.jelzo_id = jelzo.id AND c.becsengetes_id = becsengetes.id AND c.kicsengetes_id = kicsengetes.id ORDER BY c.oraszam", con);
                new MySqlCommandBuilder(adapterRöviditett);
                dtRöviditett = new DataTable();
                adapterRöviditett.Fill(dtRöviditett);
                datagridRöviditett.ItemsSource = dtRöviditett.DefaultView;
            }
            else if (tab.SelectedIndex == 3 && dtRendkivuli == null)
            {
                MySqlConnection con = new MySqlConnection(connectionString);
                adapterRendkivuli = new MySqlDataAdapter("SELECT c.oraszam, jelzo.idopont AS jelzo, becsengetes.idopont AS becsengetes, kicsengetes.idopont AS kicsengetes FROM csengetes c, orak jelzo, orak becsengetes, orak kicsengetes WHERE c.nap_id = 3 AND c.jelzo_id = jelzo.id AND c.becsengetes_id = becsengetes.id AND c.kicsengetes_id = kicsengetes.id ORDER BY c.oraszam", con);
                new MySqlCommandBuilder(adapterRendkivuli);
                dtRendkivuli = new DataTable();
                adapterRendkivuli.Fill(dtRendkivuli);
                datagridRendkivuli.ItemsSource = dtRendkivuli.DefaultView;
            }
        }

        private int GetOrInsertOraId(MySqlConnection con, string idopont)
        {
            MySqlCommand selectCmd = new MySqlCommand("SELECT id FROM orak WHERE idopont = @idopont", con);
            selectCmd.Parameters.AddWithValue("@idopont", idopont);
            object result = selectCmd.ExecuteScalar();

            if (result != null)
                return Convert.ToInt32(result);

            MySqlCommand insertCmd = new MySqlCommand("INSERT INTO orak (idopont) VALUES (@idopont); SELECT LAST_INSERT_ID();", con);
            insertCmd.Parameters.AddWithValue("@idopont", idopont);
            return Convert.ToInt32(insertCmd.ExecuteScalar());
        }

        private void MentesNormal_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                MySqlConnection con = new MySqlConnection(connectionString);
                con.Open();

                foreach (DataRow row in dtNormal.Rows)
                {
                    if (row.RowState == DataRowState.Modified)
                    {
                        int jelzoId = GetOrInsertOraId(con, row["jelzo"].ToString());
                        int becsId = GetOrInsertOraId(con, row["becsengetes"].ToString());
                        int kicsId = GetOrInsertOraId(con, row["kicsengetes"].ToString());

                        MySqlCommand cmd = new MySqlCommand(@"
                            UPDATE csengetes 
                            SET jelzo_id = @jelzo_id, becsengetes_id = @becs_id, kicsengetes_id = @kics_id
                            WHERE nap_id = 1 AND oraszam = @oraszam", con);

                        cmd.Parameters.AddWithValue("@jelzo_id", jelzoId);
                        cmd.Parameters.AddWithValue("@becs_id", becsId);
                        cmd.Parameters.AddWithValue("@kics_id", kicsId);
                        cmd.Parameters.AddWithValue("@oraszam", row["oraszam"]);
                        cmd.ExecuteNonQuery();
                    }
                }

                con.Close();
                dtNormal.AcceptChanges();
                MessageBox.Show("Sikeresen mentve!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba: " + ex.Message);
            }
        }

        private void MentesRöviditett_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                MySqlConnection con = new MySqlConnection(connectionString);
                con.Open();

                foreach (DataRow row in dtRöviditett.Rows)
                {
                    if (row.RowState == DataRowState.Modified)
                    {
                        int jelzoId = GetOrInsertOraId(con, row["jelzo"].ToString());
                        int becsId = GetOrInsertOraId(con, row["becsengetes"].ToString());
                        int kicsId = GetOrInsertOraId(con, row["kicsengetes"].ToString());

                        MySqlCommand cmd = new MySqlCommand(@"
                            UPDATE csengetes 
                            SET jelzo_id = @jelzo_id, becsengetes_id = @becs_id, kicsengetes_id = @kics_id
                            WHERE nap_id = 2 AND oraszam = @oraszam", con);

                        cmd.Parameters.AddWithValue("@jelzo_id", jelzoId);
                        cmd.Parameters.AddWithValue("@becs_id", becsId);
                        cmd.Parameters.AddWithValue("@kics_id", kicsId);
                        cmd.Parameters.AddWithValue("@oraszam", row["oraszam"]);
                        cmd.ExecuteNonQuery();
                    }
                }

                con.Close();
                dtRöviditett.AcceptChanges();
                MessageBox.Show("Sikeresen mentve!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba: " + ex.Message);
            }
        }

        private void MentesRendkivuli_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                MySqlConnection con = new MySqlConnection(connectionString);
                con.Open();

                foreach (DataRow row in dtRendkivuli.Rows)
                {
                    if (row.RowState == DataRowState.Modified)
                    {
                        int jelzoId = GetOrInsertOraId(con, row["jelzo"].ToString());
                        int becsId = GetOrInsertOraId(con, row["becsengetes"].ToString());
                        int kicsId = GetOrInsertOraId(con, row["kicsengetes"].ToString());

                        MySqlCommand cmd = new MySqlCommand(@"
                            UPDATE csengetes 
                            SET jelzo_id = @jelzo_id, becsengetes_id = @becs_id, kicsengetes_id = @kics_id
                            WHERE nap_id = 3 AND oraszam = @oraszam", con);

                        cmd.Parameters.AddWithValue("@jelzo_id", jelzoId);
                        cmd.Parameters.AddWithValue("@becs_id", becsId);
                        cmd.Parameters.AddWithValue("@kics_id", kicsId);
                        cmd.Parameters.AddWithValue("@oraszam", row["oraszam"]);
                        cmd.ExecuteNonQuery();
                    }
                }

                con.Close();
                dtRendkivuli.AcceptChanges();
                MessageBox.Show("Sikeresen mentve!");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba: " + ex.Message);
            }
        }

        private void Toggle(Ellipse clicked, Button activeBtn)
        {
            var red = new SolidColorBrush(Color.FromRgb(0xF4, 0x43, 0x36));
            var green = new SolidColorBrush(Color.FromRgb(0x4C, 0xAF, 0x50));
            var borderDefault = new SolidColorBrush(Color.FromRgb(0xE0, 0xE0, 0xE0));

            foreach (var (d, b) in new[] { (dot1, btn1), (dot2, btn2), (dot3, btn3) })
            {
                d.Fill = red;
                b.BorderBrush = borderDefault;
            }

            clicked.Fill = green;
            activeBtn.BorderBrush = green;
        }

        private void BtnCsengo1_Click(object sender, RoutedEventArgs e) => Toggle(dot1, btn1);
        private void BtnCsengo2_Click(object sender, RoutedEventArgs e) => Toggle(dot2, btn2);
        private void BtnCsengo3_Click(object sender, RoutedEventArgs e) => Toggle(dot3, btn3);
    }
}