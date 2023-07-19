#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <SPI.h>
#include <MFRC522.h>
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>

#define OLED_ADDRESS 0x3C // OLED I2C address (may vary depending on the OLED module)
#define RST_PIN 0         // GPIO pin connected to RC522 module reset
#define SS_PIN 2          // GPIO pin connected to RC522 module chip select
#define BUZZER_PIN 15

Adafruit_SSD1306 display(128, 64, &Wire, -1);
MFRC522 mfrc522(SS_PIN, RST_PIN);

char auth[] = "Tl9Nroq1FgOKSwE-Hv_CewzuaBy7UZTt"; // Blynk authentication token
char ssid[] = "Ngoc";        // Wi-Fi network SSID
char password[] = "1122334455"; // Wi-Fi network password

void setup() {
  Wire.begin();
  SPI.begin();
  mfrc522.PCD_Init();

  display.begin(SSD1306_SWITCHCAPVCC, OLED_ADDRESS);

  display.clearDisplay();
  display.setTextColor(WHITE);
  display.setTextSize(2);
  display.setCursor(0, 0);
  display.println("RFID Reader");
  display.display();

  Blynk.begin(auth, ssid, password); // Connect to Blynk server

  pinMode(BUZZER_PIN, OUTPUT); 
  digitalWrite(BUZZER_PIN, LOW);
}

void loop() {
  Blynk.run(); // Run Blynk library

  if (!mfrc522.PICC_IsNewCardPresent() || !mfrc522.PICC_ReadCardSerial()) {
    delay(100);
    return;
  }

  String tagID = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    tagID.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? "0" : ""));
    tagID.concat(String(mfrc522.uid.uidByte[i], HEX));
  }

  mfrc522.PICC_HaltA();
  display.clearDisplay();
  display.setTextColor(WHITE);
  display.setTextSize(2);
  display.setCursor(0, 0);
  display.println("RFID:");
  display.setTextSize(2);
  display.setCursor(0, 24);
  display.println(tagID);
  display.display();

  Blynk.virtualWrite(V1, tagID); // Send tagID to Blynk server

  digitalWrite(BUZZER_PIN, HIGH);
  delay(300);
  digitalWrite(BUZZER_PIN, LOW);

  delay(1000);
}
