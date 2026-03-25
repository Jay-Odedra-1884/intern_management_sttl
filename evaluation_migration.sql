-- ─────────────────────────────────────────────────────────────────────────────
-- Migration: Alter evaluations table
-- Run this on any existing database that was set up from the original schema
-- psql -U postgres -d your_database_name -f evaluation_migration.sql
-- ─────────────────────────────────────────────────────────────────────────────

ALTER TABLE public.evaluations
  ADD COLUMN IF NOT EXISTS technical_skill_score  integer,
  ADD COLUMN IF NOT EXISTS problem_solving_score  integer,
  ADD COLUMN IF NOT EXISTS communication_score    integer,
  ADD COLUMN IF NOT EXISTS teamwork_score         integer,
  ADD COLUMN IF NOT EXISTS initiative_score       integer,
  ADD COLUMN IF NOT EXISTS time_management_score  integer,
  ADD COLUMN IF NOT EXISTS learning_ability_score integer,
  ADD COLUMN IF NOT EXISTS ownership_score        integer,
  ADD COLUMN IF NOT EXISTS overall_score          numeric(4,1),
  ADD COLUMN IF NOT EXISTS strengths              text,
  ADD COLUMN IF NOT EXISTS improvement_areas      text,
  ADD COLUMN IF NOT EXISTS mentor_feedback        text;

-- Constraints: all skill scores must be between 1 and 10 if provided
ALTER TABLE public.evaluations
  ADD CONSTRAINT evaluations_technical_skill_score_check    CHECK (technical_skill_score  BETWEEN 1 AND 10),
  ADD CONSTRAINT evaluations_problem_solving_score_check    CHECK (problem_solving_score  BETWEEN 1 AND 10),
  ADD CONSTRAINT evaluations_communication_score_check      CHECK (communication_score    BETWEEN 1 AND 10),
  ADD CONSTRAINT evaluations_teamwork_score_check           CHECK (teamwork_score         BETWEEN 1 AND 10),
  ADD CONSTRAINT evaluations_initiative_score_check         CHECK (initiative_score       BETWEEN 1 AND 10),
  ADD CONSTRAINT evaluations_time_management_score_check    CHECK (time_management_score  BETWEEN 1 AND 10),
  ADD CONSTRAINT evaluations_learning_ability_score_check   CHECK (learning_ability_score BETWEEN 1 AND 10),
  ADD CONSTRAINT evaluations_ownership_score_check          CHECK (ownership_score        BETWEEN 1 AND 10),
  ADD CONSTRAINT evaluations_overall_score_check            CHECK (overall_score          BETWEEN 1 AND 10);