using System.Configuration;
using System.Windows;

namespace DoCoffee.App
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            ApiKeyLabel.Content = $"ApiKey: {ConfigurationManager.AppSettings["ApiKey"]}";

            var encryptedSecret = ConfigurationManager.AppSettings["EncryptedSecret"];
            var decryptedSecret = App.EncryptionService.Decrypt(encryptedSecret);

            DecryptedSecretLabel.Content = $"Decrypted Secret: {decryptedSecret}";
        }
    }
}
