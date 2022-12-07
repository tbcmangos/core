**~~######################################################################################~~**

HellGround Core (Wargate core) has been released as public as of Classic-TBC release.

# **This is an archive and is no longer maintained. **
https://github.com/Acrivec/Hellground_database/commit/ee4a706a958e0c9d040098234c8b692c6d74202b
##You're welcome to join us on discord.
https://discord.com/invite/X3Kb3ad
**~~######################################################################################~~**


Database Repository for the HellGround Core Project.
Copyright (C) 2008-2014 HellGround team <http://hellground.net/>


Folder structure

    dbcs
        Can contain DBC files converted to SQL format for simpler access (can be
        helpful while fixing something).

    structures
        Contains SQL files with database structures and data updated to specific
        core revision (revision number is in struct_revisions text file).

    tools
        Contains various SQL tools.

    updates
        Contains updates to specific databases.

    updates/*/old
        Contains already applied updates to the base file (structures/*.sql or
        world.sql).

World database dump

World database located in structures is an old dump and will not be updated by
replacing the file. To keep updated, please check the repo's downloads tab. The
filename contains core revision (bigger number) and db revision (lower number).

Naming conventions

- Changes linked with the core will be still named as `HG_corerev.sql`.
- Structural changes would be named like `HG_corerev_tablename.sql`.
- DB only changes that do NOT require core changes mark as: `HG_corerev_DB_dbrev.sql`.
  If there is no new rev in core repository use the last one, the core rev number
  is important because we also need an exact execution order also for DB only
  updates. Example, core rev. nnnn changes the structure of the world DB, so we
  need to execute DB only changes on this table in the right order, else we have
  execution errors. This makes easier to use a script to combine all updates into
  one file.
- Remember to use descriptive commit names.

Live server updates

Approve on a commit means 'everything up to, and with this, commit, has been
applied to the server' - Elyrion.
