namespace DoCoffee.App
{
    public static class EnvironmentHelper
    {
        public static bool IsDevelopment()
        {
#if DEBUG
            return true;
#else
return false;
#endif
        }
        public static bool IsProduction()
        {
#if RELEASE
return true;
#else
            return false;
#endif
        }
        public static bool IsStaging()
        {
#if STAGING
return true;
#else
            return false;
#endif
        }
        public static string GetEnvironmentName() => IsProduction() ? "Production" : IsDevelopment() ? "Development" : "Staging";
    }
}
