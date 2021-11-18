# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

aragonite: yes
remote_dependency: test {
  url: "https://github.com/tjbanghart/block-google-chronicle"
  ref: "test"
  override_constant: CONNECTION_NAME {
    value: "whatever"
  }
  override_constant: DATASET_NAME {
    value: "whatever"
  }
  override_constant: CHRONICLE_URL {
    value: "whatever"
  }
}
##
