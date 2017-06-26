# Created to satisfy this:
# DEPRECATION WARNING: Currently, Active Record suppresses errors raised within
# `after_rollback`/`after_commit` callbacks and only print them to the logs.
# In the next version, these errors will no longer be suppressed. Instead, the
# errors will propagate normally just like in other Active Record callbacks.
# You can opt into the new behavior and remove this warning by setting:

Rails.application.config.active_record.raise_in_transactional_callbacks = true
