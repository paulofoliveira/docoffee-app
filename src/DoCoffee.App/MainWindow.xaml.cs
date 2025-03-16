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

            ApiKeyLabel.Content = $"ApiKey: {ConfigurationManagerHelper.AppSettings.Get("ApiKey")}";
            DecryptedSecretLabel.Content = $"MySecret: {ConfigurationManagerHelper.AppSettings.Get("MySecret")}";
        }
    }
}
