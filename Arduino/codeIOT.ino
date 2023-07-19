#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <SPI.h>
#include <MFRC522.h>
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>

#define OLED_ADDRESS 0x3C // OLED I2C address (may vary depending on the OLED module)
#define RST_PIN 0         // GPIO pin connected to RC522 module reset
#define SS_PIN 2          // GPIO pin connected to RC522 module chip select
#define BUZZER_PIN 15

Adafruit_SSD1306 display(128, 64, &Wire, -1);
MFRC522 mfrc522(SS_PIN, RST_PIN);

char auth[] = "Tl9Nroq1FgOKSwE-Hv_CewzuaBy7UZTt"; // Blynk authentication token
char ssid[] = "LINH HOMIE F3 A";        // Wi-Fi network SSID
char password[] = "LINHHOMIEcamon"; // Wi-Fi network password
const char* apiEndpoint = "http://www.nqngoc.id.vn/post_NewStudent.php";

void setup() {
  Serial.begin(115200);
  Wire.begin();
  SPI.begin();
  mfrc522.PCD_Init();
  WiFi.begin(ssid, password);

  display.begin(SSD1306_SWITCHCAPVCC, OLED_ADDRESS);

  display.clearDisplay();
  display.setTextColor(WHITE);
  display.setTextSize(2);
  display.setCursor(0, 0);
  display.println("RFID Reader");
  display.display();

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");

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

  WiFiClient client; // Create WiFiClient object
  HTTPClient http;
  http.begin(client, apiEndpoint); // Pass WiFiClient object to begin()

  http.addHeader("Content-Type", "application/x-www-form-urlencoded");

  String postData = "rfid=" + tagID;
  int httpResponseCode = http.POST(postData);
  if (httpResponseCode > 0) {
    Serial.print("API response code: ");
    Serial.println(httpResponseCode);
    String response = http.getString();
    Serial.println(response);
  } else {
    Serial.print("Error sending request. HTTP error code: ");
    Serial.println(httpResponseCode);
  }

  http.end();

  Blynk.virtualWrite(V1, tagID); // Send tagID to Blynk server

  digitalWrite(BUZZER_PIN, HIGH);
  delay(300);
  digitalWrite(BUZZER_PIN, LOW);

  delay(1000);
}
