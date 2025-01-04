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

                if (EnvironmentHelper.IsDevelopment())
                    return value;

                return App.EncryptionService.Decrypt(value);
            }
        }
    }
}
