using DoCoffee.App.Services;
using System.Windows;
using ApplicationResources = DoCoffee.App.Properties.Resources;

namespace DoCoffee.App
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        public static EncrpytionService EncryptionService = new EncrpytionService(ApplicationResources.EncryptionKey);
    }
}
