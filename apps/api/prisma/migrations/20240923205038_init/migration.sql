/*
  Warnings:

  - You are about to drop the column `expiresAt` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `expiresAt` on the `PasswordResetToken` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `PasswordResetToken` table. All the data in the column will be lost.
  - Added the required column `expires_at` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `Session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `expires_at` to the `PasswordResetToken` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `PasswordResetToken` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "user_id" TEXT NOT NULL,
    "expires_at" DATETIME NOT NULL,
    CONSTRAINT "Session_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Session" ("id") SELECT "id" FROM "Session";
DROP TABLE "Session";
ALTER TABLE "new_Session" RENAME TO "Session";
CREATE TABLE "new_PasswordResetToken" (
    "user_id" TEXT NOT NULL,
    "hashed_token" TEXT NOT NULL,
    "expires_at" DATETIME NOT NULL,
    CONSTRAINT "PasswordResetToken_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_PasswordResetToken" ("hashed_token") SELECT "hashed_token" FROM "PasswordResetToken";
DROP TABLE "PasswordResetToken";
ALTER TABLE "new_PasswordResetToken" RENAME TO "PasswordResetToken";
CREATE UNIQUE INDEX "PasswordResetToken_user_id_key" ON "PasswordResetToken"("user_id");
CREATE UNIQUE INDEX "PasswordResetToken_hashed_token_key" ON "PasswordResetToken"("hashed_token");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
