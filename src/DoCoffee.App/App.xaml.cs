using DoCoffee.App.Services;
using System.Windows;

namespace DoCoffee.App
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        private static string EncryptionKey = "c#H<R$oN&W7L13+";
        public static EncrpytionService EncryptionService = new EncrpytionService(EncryptionKey);
    }
}
