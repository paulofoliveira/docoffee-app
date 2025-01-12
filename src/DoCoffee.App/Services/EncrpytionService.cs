using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace DoCoffee.App.Services
{
    public class EncrpytionService
    {
        private readonly string _encryptionKey;
        private readonly byte[] _encryptionKeyInBytes;
        private static readonly byte[] IV = { 12, 34, 56, 78, 90, 102, 114, 126 };
        public EncrpytionService(string encryptionKey)
        {
            _encryptionKey = encryptionKey ?? throw new ArgumentNullException(nameof(encryptionKey));
            _encryptionKeyInBytes = Encoding.UTF8.GetBytes(encryptionKey);
        }
        public string Decrypt(string value)
        {
            if (value == null)
                throw new ArgumentNullException(nameof(value));

            if (EnvironmentHelper.IsDevelopment())
                return value;

            using var des = new DESCryptoServiceProvider();
            using var ms = new MemoryStream();
            var input = Convert.FromBase64String(value.Replace(" ", "+"));
            using var cs = new CryptoStream(ms, des.CreateDecryptor(_encryptionKeyInBytes, IV), CryptoStreamMode.Write);
            cs.Write(input, 0, input.Length);
            cs.FlushFinalBlock();
            return Encoding.UTF8.GetString(ms.ToArray());
        }
    }
}
