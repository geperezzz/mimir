-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE');

-- CreateTable
CREATE TABLE "Author" (
    "id" UUID NOT NULL,

    CONSTRAINT "Author_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PersonalInfo" (
    "id" UUID NOT NULL,
    "authorId" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "pseudonim" TEXT,
    "birthDate" DATE NOT NULL,
    "deathDate" DATE NOT NULL,
    "gender" "Gender" NOT NULL,
    "parents" TEXT[],
    "children" TEXT[],
    "siblings" TEXT[],

    CONSTRAINT "PersonalInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PersonalInfoMultimedia" (
    "id" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "copyright" TEXT NOT NULL,
    "reference" TEXT NOT NULL,
    "personalInfoId" UUID NOT NULL,

    CONSTRAINT "PersonalInfoMultimedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RelevantActivity" (
    "id" UUID NOT NULL,
    "personalInfoId" UUID NOT NULL,
    "activity" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "place" TEXT NOT NULL,
    "placeSite" TEXT NOT NULL,
    "activityStartTimestamp" TIMESTAMP(3) NOT NULL,
    "activityEndTimestamp" TIMESTAMP(3) NOT NULL,
    "awardsReceived" TEXT[],
    "groups" TEXT[],
    "magazines" TEXT[],

    CONSTRAINT "RelevantActivity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkAboutAuthor" (
    "id" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "authorId" UUID NOT NULL,
    "elaborationDate" DATE NOT NULL,
    "reference" TEXT NOT NULL,
    "referencedAuthorId" UUID NOT NULL,

    CONSTRAINT "WorkAboutAuthor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkAboutAuthorMultimedia" (
    "id" UUID NOT NULL,
    "workId" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "copyright" TEXT NOT NULL,
    "reference" TEXT NOT NULL,

    CONSTRAINT "WorkAboutAuthorMultimedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Phase" (
    "id" UUID NOT NULL,
    "phase" TEXT NOT NULL,
    "startDate" DATE NOT NULL,
    "endDate" DATE NOT NULL,
    "trend" TEXT NOT NULL,
    "movement" TEXT NOT NULL,
    "style" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "authorId" UUID NOT NULL,

    CONSTRAINT "Phase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Work" (
    "id" UUID NOT NULL,
    "genre" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "meter" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "originalLanguage" TEXT NOT NULL,
    "elaborationStartDate" DATE NOT NULL,
    "elaborationEndDate" DATE NOT NULL,
    "elaborationPlaces" TEXT[],
    "authorPhaseId" UUID NOT NULL,

    CONSTRAINT "Work_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkMultimedia" (
    "id" UUID NOT NULL,
    "workId" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "copyright" TEXT NOT NULL,
    "reference" TEXT NOT NULL,

    CONSTRAINT "WorkMultimedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Publication" (
    "id" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "publicationDate" DATE NOT NULL,
    "publicationPlace" TEXT NOT NULL,
    "edition" TEXT NOT NULL,
    "publisher" TEXT NOT NULL,
    "language" TEXT NOT NULL,
    "translator" TEXT NOT NULL,
    "workId" UUID NOT NULL,

    CONSTRAINT "Publication_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PublicationMultimedia" (
    "id" UUID NOT NULL,
    "publicationId" UUID NOT NULL,
    "description" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "copyright" TEXT NOT NULL,
    "reference" TEXT NOT NULL,

    CONSTRAINT "PublicationMultimedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkAboutWork" (
    "id" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "authorId" UUID NOT NULL,
    "elaborationDate" DATE NOT NULL,
    "reference" TEXT NOT NULL,
    "referencedWorkId" UUID NOT NULL,

    CONSTRAINT "WorkAboutWork_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkAboutWorkMultimedia" (
    "id" UUID NOT NULL,
    "workId" UUID NOT NULL,
    "description" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "copyright" TEXT NOT NULL,
    "reference" TEXT NOT NULL,

    CONSTRAINT "WorkAboutWorkMultimedia_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PersonalInfo_authorId_key" ON "PersonalInfo"("authorId");

-- CreateIndex
CREATE UNIQUE INDEX "RelevantActivity_personalInfoId_activity_activityStartTimes_key" ON "RelevantActivity"("personalInfoId", "activity", "activityStartTimestamp");

-- CreateIndex
CREATE UNIQUE INDEX "WorkAboutAuthor_authorId_elaborationDate_referencedAuthorId_key" ON "WorkAboutAuthor"("authorId", "elaborationDate", "referencedAuthorId");

-- CreateIndex
CREATE UNIQUE INDEX "Phase_authorId_startDate_key" ON "Phase"("authorId", "startDate");

-- CreateIndex
CREATE UNIQUE INDEX "Work_title_elaborationStartDate_authorPhaseId_key" ON "Work"("title", "elaborationStartDate", "authorPhaseId");

-- CreateIndex
CREATE UNIQUE INDEX "Publication_workId_publisher_publicationDate_publicationPla_key" ON "Publication"("workId", "publisher", "publicationDate", "publicationPlace");

-- CreateIndex
CREATE UNIQUE INDEX "WorkAboutWork_authorId_elaborationDate_referencedWorkId_key" ON "WorkAboutWork"("authorId", "elaborationDate", "referencedWorkId");

-- AddForeignKey
ALTER TABLE "PersonalInfo" ADD CONSTRAINT "PersonalInfo_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Author"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PersonalInfoMultimedia" ADD CONSTRAINT "PersonalInfoMultimedia_personalInfoId_fkey" FOREIGN KEY ("personalInfoId") REFERENCES "PersonalInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RelevantActivity" ADD CONSTRAINT "RelevantActivity_personalInfoId_fkey" FOREIGN KEY ("personalInfoId") REFERENCES "PersonalInfo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkAboutAuthor" ADD CONSTRAINT "WorkAboutAuthor_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Author"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkAboutAuthor" ADD CONSTRAINT "WorkAboutAuthor_referencedAuthorId_fkey" FOREIGN KEY ("referencedAuthorId") REFERENCES "Author"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkAboutAuthorMultimedia" ADD CONSTRAINT "WorkAboutAuthorMultimedia_workId_fkey" FOREIGN KEY ("workId") REFERENCES "WorkAboutAuthor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Phase" ADD CONSTRAINT "Phase_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Author"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Work" ADD CONSTRAINT "Work_authorPhaseId_fkey" FOREIGN KEY ("authorPhaseId") REFERENCES "Phase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkMultimedia" ADD CONSTRAINT "WorkMultimedia_workId_fkey" FOREIGN KEY ("workId") REFERENCES "Work"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Publication" ADD CONSTRAINT "Publication_workId_fkey" FOREIGN KEY ("workId") REFERENCES "Work"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PublicationMultimedia" ADD CONSTRAINT "PublicationMultimedia_publicationId_fkey" FOREIGN KEY ("publicationId") REFERENCES "Publication"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkAboutWork" ADD CONSTRAINT "WorkAboutWork_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "Author"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkAboutWork" ADD CONSTRAINT "WorkAboutWork_referencedWorkId_fkey" FOREIGN KEY ("referencedWorkId") REFERENCES "Work"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkAboutWorkMultimedia" ADD CONSTRAINT "WorkAboutWorkMultimedia_workId_fkey" FOREIGN KEY ("workId") REFERENCES "WorkAboutWork"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
