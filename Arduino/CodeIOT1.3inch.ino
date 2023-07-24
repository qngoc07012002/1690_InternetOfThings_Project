#include <Wire.h>
#include <U8g2lib.h>
#include <SPI.h>
#include <MFRC522.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <ArduinoJson.h>

#define OLED_ADDRESS 0x3C 
#define RST_PIN 0         
#define SS_PIN 2          
#define BUZZER_PIN 15

U8G2_SSD1306_128X64_NONAME_F_HW_I2C u8g2(U8G2_R0, /* reset=*/ U8X8_PIN_NONE);
MFRC522 mfrc522(SS_PIN, RST_PIN);

char ssid[] = "LINH HOMIE F3 A";       
char password[] = "LINHHOMIEcamon"; 
int COUNT_TIME = 0;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  SPI.begin();
  mfrc522.PCD_Init();
  WiFi.begin(ssid, password);

  u8g2.begin();

  u8g2.clearBuffer();
  u8g2.setFont(u8g2_font_ncenB08_tr);
  u8g2.setCursor(0, 0);
  u8g2.print("Connecting to WiFi...");
  u8g2.sendBuffer();

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
  }

  u8g2.clearBuffer();
  u8g2.print("Connected to WiFi!");
  u8g2.sendBuffer();

  delay(1000);

  displayMainScreen();

  pinMode(BUZZER_PIN, OUTPUT);
  digitalWrite(BUZZER_PIN, LOW);
}

void loop() {
  if (COUNT_TIME == 50) {
    displayMainScreen();
    COUNT_TIME = 0;
  }

  if (!mfrc522.PICC_IsNewCardPresent() || !mfrc522.PICC_ReadCardSerial()) {
    COUNT_TIME++;
    delay(100);
    return;
  } else COUNT_TIME = 0;

  String tagID = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    tagID.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? "0" : ""));
    tagID.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  tagID.toUpperCase();
  mfrc522.PICC_HaltA();

  getStudentInfo(tagID);

  digitalWrite(BUZZER_PIN, HIGH);
  delay(300);
  digitalWrite(BUZZER_PIN, LOW);

  delay(1000);
}

void displayMainScreen() {
  u8g2.clearBuffer();
  u8g2.setFont(u8g2_font_ncenB14_tr);
  u8g2.setCursor(25, 16);
  u8g2.print("Student");
  u8g2.setCursor(10, 36);
  u8g2.print("Attendance");
  u8g2.sendBuffer();
}

void postNewStudent(String tagID) {
  String url = "http://www.nqngoc.id.vn/post_NewStudent.php";
  WiFiClient client;
  HTTPClient http;
  http.begin(client, url);

  http.addHeader("Content-Type", "application/x-www-form-urlencoded");

  String postData = "rfid=" + tagID;
  int httpResponseCode = http.POST(postData);

  http.end();
}

void getStudentInfo(String tagID) {
  String url = "http://www.nqngoc.id.vn/get_StudentInfomation.php?rfid=" + tagID;
  WiFiClient client;
  HTTPClient http;
  String payload = "";

  http.begin(client, url);
  int httpCode = http.GET();

  if (httpCode == HTTP_CODE_OK) {
    payload = http.getString();
    http.end();

  }

  http.end();

  parseStudentInfo(tagID, payload);
}

void parseStudentInfo(String tagID, String studentInfo) {
  StaticJsonDocument<192> doc;

  DeserializationError error = deserializeJson(doc, studentInfo);

  if (error) {
    Serial.print(F("deserializeJson() failed: "));
    Serial.println(error.f_str());
    return;
  }
  const char* name = doc["Name"];
  const char* studentCode = doc["Student_Code"]; 

  displayStudentInformation(tagID, name, studentCode);

}

void displayStudentInformation(String rfid, String name, String studentCode) {
  u8g2.clearBuffer();
  u8g2.setFont(u8g2_font_ncenB08_tr);
  if (name.isEmpty()) {
    Serial.println(rfid);
    postNewStudent(rfid);
    u8g2.setCursor(5, 10);
    u8g2.print("New Student");
  } else {
    u8g2.setCursor(5, 10);
    u8g2.print(name);
    u8g2.setCursor(5, 25);
    u8g2.print(studentCode);
  }
  u8g2.sendBuffer();
}