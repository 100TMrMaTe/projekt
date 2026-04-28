using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text.Json;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;
using System.Windows.Threading;
using Microsoft.Win32;

namespace csengetes
{
    // ── Beállítások modell ────────────────────────────────────────────────
    public class DbSettings
    {
        public string Server { get; set; } = "localhost";
        public string Database { get; set; } = "projekt";
        public string User { get; set; } = "root";
        public string Password { get; set; } = "";
    }

    public partial class MainWindow : Window
    {
        // ── Beállítások fájl elérési útja ─────────────────────────────────
        // MSIX-nél a BaseDirectory csak olvasható! Az AppData mappát kell használni.
        private static readonly string SettingsPath =
            System.IO.Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData),
                "csengetes",
                "settings.json");

        private DbSettings _dbSettings = new DbSettings();

        // ── Connection string (mindig az aktuális beállításból épül) ───────
        private string ConnectionString =>
            $"Server={_dbSettings.Server};" +
            $"Database={_dbSettings.Database};" +
            $"User={_dbSettings.User};" +
            $"Password={_dbSettings.Password};";

        public MainWindow()
        {
            InitializeComponent();
            LoadSettings();          // betölti a settings.json-t (vagy alapértelmezettet)
            Toggle(dot1, btn1);
            SetAktivNapId(1);
            StartScheduler();
        }

        // ── Beállítások: betöltés / mentés ────────────────────────────────
        private void LoadSettings()
        {
            try
            {
                if (File.Exists(SettingsPath))
                {
                    string json = File.ReadAllText(SettingsPath);
                    _dbSettings = JsonSerializer.Deserialize<DbSettings>(json) ?? new DbSettings();
                }
            }
            catch
            {
                _dbSettings = new DbSettings();
            }
        }

        private void SaveSettings()
        {
            // Mappa létrehozása ha nem létezik (első mentésnél)
            string dir = System.IO.Path.GetDirectoryName(SettingsPath);
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            string json = JsonSerializer.Serialize(_dbSettings,
                new JsonSerializerOptions { WriteIndented = true });
            File.WriteAllText(SettingsPath, json);
        }

        // A Beállítások fül mezőit feltölti az aktuális értékekkel
        private void FillSettingsFields()
        {
            txtDbServer.Text = _dbSettings.Server;
            txtDbName.Text = _dbSettings.Database;
            txtDbUser.Text = _dbSettings.User;
            txtDbPassword.Password = _dbSettings.Password;
        }

        // ── Mentés gomb (Beállítások fül) ────────────────────────────────
        private void MentesBeallitasok_Click(object sender, RoutedEventArgs e)
        {
            _dbSettings.Server = txtDbServer.Text.Trim();
            _dbSettings.Database = txtDbName.Text.Trim();
            _dbSettings.User = txtDbUser.Text.Trim();
            _dbSettings.Password = txtDbPassword.Password;

            SaveSettings();

            // Adatok újratöltésre kényszerítése (ha a kapcsolat megváltozott)
            dtNormal = null;
            dtRöviditett = null;
            dtRendkivuli = null;

            MessageBox.Show("Beállítások elmentve!", "Mentés", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        // ── Adapterek ─────────────────────────────────────────────────────
        private MySqlDataAdapter adapterNormal;
        private MySqlDataAdapter adapterRendkivuli;
        private MySqlDataAdapter adapterRöviditett;
        private DataTable dtNormal;
        private DataTable dtRendkivuli;
        private DataTable dtRöviditett;

        private int _aktivNapId = 1;

        // ── Időzítő ───────────────────────────────────────────────────────
        private DispatcherTimer _scheduler;
        private int _lastTriggeredMinute = -1;

        private void StartScheduler()
        {
            _scheduler = new DispatcherTimer { Interval = TimeSpan.FromSeconds(1) };
            _scheduler.Tick += Scheduler_Tick;
            _scheduler.Start();
        }

        private void Scheduler_Tick(object sender, EventArgs e)
        {
            var now = DateTime.Now;
            int currentMinuteKey = now.Hour * 60 + now.Minute;

            if (now.Second != 0 || currentMinuteKey == _lastTriggeredMinute)
                return;

            try
            {
                using MySqlConnection con = new MySqlConnection(ConnectionString);
                con.Open();

                using var cmd = new MySqlCommand("SELECT idopont FROM orak WHERE aktive = 1", con);
                using var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    TimeSpan t = (TimeSpan)reader.GetValue(0);
                    if (t.Hours == now.Hour && t.Minutes == now.Minute)
                    {
                        _lastTriggeredMinute = currentMinuteKey;
                        PlayCsengo();
                        break;
                    }
                }
            }
            catch { }
        }

        // ── MP3 ───────────────────────────────────────────────────────────
        private string _mp3FilePath = string.Empty;

        private void BtnBrowseMp3_Click(object sender, RoutedEventArgs e)
        {
            var dlg = new OpenFileDialog
            {
                Filter = "Hangfájl|*.mp3;*.wav;*.m4a;*.wma|Minden fájl|*.*",
                Title = "Válassz csengetési hangot"
            };

            if (dlg.ShowDialog() == true)
            {
                _mp3FilePath = dlg.FileName;
                txtMp3Name.Text = System.IO.Path.GetFileName(_mp3FilePath);
                txtMp3Status.Text = "Kész a lejátszásra";
                mediaPlayer.Source = new Uri(_mp3FilePath, UriKind.Absolute);
                mediaPlayer.Stop();
            }
        }

        private void BtnTestPlay_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(_mp3FilePath) || !File.Exists(_mp3FilePath))
            {
                MessageBox.Show("Előbb válassz ki egy hangfájlt!", "Nincs fájl");
                return;
            }
            mediaPlayer.Stop();
            mediaPlayer.Position = TimeSpan.Zero;
            mediaPlayer.Play();
            txtMp3Status.Text = "▶ Lejátszás...";
        }

        private void BtnStop_Click(object sender, RoutedEventArgs e)
        {
            mediaPlayer.Stop();
            mediaPlayer.Position = TimeSpan.Zero;
            txtMp3Status.Text = "⏹ Megállítva";
        }

        public void PlayCsengo()
        {
            if (string.IsNullOrEmpty(_mp3FilePath) || !File.Exists(_mp3FilePath))
                return;

            mediaPlayer.Stop();
            mediaPlayer.Position = TimeSpan.Zero;
            mediaPlayer.Play();
        }

        // ── Tab váltás ────────────────────────────────────────────────────
        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var tab = sender as TabControl;
            if (tab == null) return;

            // Beállítások fül (index 4) – mezők frissítése
            if (tab.SelectedIndex == 4)
            {
                FillSettingsFields();
                return;
            }

            if (tab.SelectedIndex == 1 && dtNormal == null)
            {
                MySqlConnection con = new MySqlConnection(ConnectionString);
                adapterNormal = new MySqlDataAdapter("SELECT c.oraszam, jelzo.idopont AS jelzo, becsengetes.idopont AS becsengetes, kicsengetes.idopont AS kicsengetes FROM csengetes c, orak jelzo, orak becsengetes, orak kicsengetes WHERE c.nap_id = 1 AND c.jelzo_id = jelzo.id AND c.becsengetes_id = becsengetes.id AND c.kicsengetes_id = kicsengetes.id ORDER BY c.oraszam", con);
                new MySqlCommandBuilder(adapterNormal);
                dtNormal = new DataTable();
                adapterNormal.Fill(dtNormal);
                datagridNormal.ItemsSource = dtNormal.DefaultView;
            }
            else if (tab.SelectedIndex == 2 && dtRöviditett == null)
            {
                MySqlConnection con = new MySqlConnection(ConnectionString);
                adapterRöviditett = new MySqlDataAdapter("SELECT c.oraszam, jelzo.idopont AS jelzo, becsengetes.idopont AS becsengetes, kicsengetes.idopont AS kicsengetes FROM csengetes c, orak jelzo, orak becsengetes, orak kicsengetes WHERE c.nap_id = 2 AND c.jelzo_id = jelzo.id AND c.becsengetes_id = becsengetes.id AND c.kicsengetes_id = kicsengetes.id ORDER BY c.oraszam", con);
                new MySqlCommandBuilder(adapterRöviditett);
                dtRöviditett = new DataTable();
                adapterRöviditett.Fill(dtRöviditett);
                datagridRöviditett.ItemsSource = dtRöviditett.DefaultView;
            }
            else if (tab.SelectedIndex == 3 && dtRendkivuli == null)
            {
                MySqlConnection con = new MySqlConnection(ConnectionString);
                adapterRendkivuli = new MySqlDataAdapter("SELECT c.oraszam, jelzo.idopont AS jelzo, becsengetes.idopont AS becsengetes, kicsengetes.idopont AS kicsengetes FROM csengetes c, orak jelzo, orak becsengetes, orak kicsengetes WHERE c.nap_id = 3 AND c.jelzo_id = jelzo.id AND c.becsengetes_id = becsengetes.id AND c.kicsengetes_id = kicsengetes.id ORDER BY c.oraszam", con);
                new MySqlCommandBuilder(adapterRendkivuli);
                dtRendkivuli = new DataTable();
                adapterRendkivuli.Fill(dtRendkivuli);
                datagridRendkivuli.ItemsSource = dtRendkivuli.DefaultView;
            }
        }

        // ── Mentés ────────────────────────────────────────────────────────
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
                if (dtNormal == null)
                {
                    MessageBox.Show("Az adatok még nem töltődtek be. Kattints a Normál fülre először!", "Figyelmeztetés", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                MySqlConnection con = new MySqlConnection(ConnectionString);
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
                if (_aktivNapId == 1) SetAktivNapId(1);
                MessageBox.Show("Sikeresen mentve!");
            }
            catch (Exception ex) { MessageBox.Show("Hiba: " + ex.Message); }
        }

        private void MentesRöviditett_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (dtRöviditett == null)
                {
                    MessageBox.Show("Az adatok még nem töltődtek be. Kattints a Rövidített fülre először!", "Figyelmeztetés", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                MySqlConnection con = new MySqlConnection(ConnectionString);
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
                if (_aktivNapId == 2) SetAktivNapId(2);
                MessageBox.Show("Sikeresen mentve!");
            }
            catch (Exception ex) { MessageBox.Show("Hiba: " + ex.Message); }
        }

        private void MentesRendkivuli_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (dtRendkivuli == null)
                {
                    MessageBox.Show("Az adatok még nem töltődtek be. Kattints a Rendkívüli fülre először!", "Figyelmeztetés", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                MySqlConnection con = new MySqlConnection(ConnectionString);
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
                if (_aktivNapId == 3) SetAktivNapId(3);
                MessageBox.Show("Sikeresen mentve!");
            }
            catch (Exception ex) { MessageBox.Show("Hiba: " + ex.Message); }
        }

        // ── Toggle + csengetés gombok ──────────────────────────────────────
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

        private void BtnCsengo1_Click(object sender, RoutedEventArgs e) { Toggle(dot1, btn1); _aktivNapId = 1; SetAktivNapId(1); }
        private void BtnCsengo2_Click(object sender, RoutedEventArgs e) { Toggle(dot2, btn2); _aktivNapId = 2; SetAktivNapId(2); }
        private void BtnCsengo3_Click(object sender, RoutedEventArgs e) { Toggle(dot3, btn3); _aktivNapId = 3; SetAktivNapId(3); }

        private void SetAktivNapId(int napId)
        {
            try
            {
                using MySqlConnection con = new MySqlConnection(ConnectionString);
                con.Open();

                using (var cmdReset = new MySqlCommand("UPDATE orak SET aktive = 0", con))
                    cmdReset.ExecuteNonQuery();

                using var cmdSet = new MySqlCommand(@"
                    UPDATE orak SET aktive = 1
                    WHERE id IN (
                        SELECT jelzo_id       FROM csengetes WHERE nap_id = @napId
                        UNION
                        SELECT becsengetes_id FROM csengetes WHERE nap_id = @napId
                        UNION
                        SELECT kicsengetes_id FROM csengetes WHERE nap_id = @napId
                    )", con);
                cmdSet.Parameters.AddWithValue("@napId", napId);
                cmdSet.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Hiba az aktív beállításakor: " + ex.Message);
            }
        }
    }
}