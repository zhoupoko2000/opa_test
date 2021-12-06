package library.kubernetes.admission.mutating

import data.patches.patch1
############################################################
# PATCH rules 
#
# Note: All patch rules should start with `isValidRequest` and `isCreateOrUpdate`
############################################################

# add foo label to Dogs if not present
patch[patchCode] {
	isValidRequest
	isCreateOrUpdate
	input.request.kind.kind == "Pod"
	hasAnnotation(input.request.object, "patch1")
	not hasAnnotation(input.request.object, "patch1_set")
	patchCode = patch1.json
}
