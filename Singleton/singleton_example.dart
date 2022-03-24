      void main(List<String> args) {
        UserSettings settings = UserSettings();
        settings.isLightMode = false;
        UserSettings settingsTwo = UserSettings();
        print(settings.hashCode);
        print(settingsTwo.hashCode);
        //both hashcodes printed will be identical
      }

      class UserSettings{

        bool isLightMode = true;

        UserSettings._privateConstructor();

        static final _instance = UserSettings._privateConstructor();

        factory UserSettings() => _instance;
      }