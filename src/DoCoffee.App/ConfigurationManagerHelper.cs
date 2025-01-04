using System;
using System.Configuration;

namespace DoCoffee.App
{
    public static class ConfigurationManagerHelper
    {
        public static class AppSettings
        {
            public static string Get(string key)
            {
                if (key == null)
                    throw new ArgumentNullException(nameof(key));

                var value = ConfigurationManager.AppSettings[key];

                return value == null ? throw new NullReferenceException($"{key} cannot be found!") : App.EncryptionService.Decrypt(value);
            }
        }
    }
}
