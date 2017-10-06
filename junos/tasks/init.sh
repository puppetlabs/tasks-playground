# Show Commands
if ( $?PT_show ) then
  cli -c "show configuration $PT_show"
endif

# Set Commands
if ( $?PT_set ) then
  cli -c "edit; set $PT_set"
endif

# Delete Commands
if ( $?PT_delete ) then
  cli -c "edit; delete $PT_delete"
endif

# Delete Commands
if ( $?PT_commit ) then
  cli -c "edit; commit confirmed 1"
endif

