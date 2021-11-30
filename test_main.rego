package library.kubernetes.admission.mutating

import data.library.kubernetes.admission.mutating.test_pod as k8s

import data.patches.patch1




hasPatch(patches, patch) {
	patches[_] = patch
}

isPatchResponse(res) {
	res.response.patchType = "JSONPatch"
	res.response.patch
}

#-----------------------------------------------------------
# Test: patches are created for good pod
#-----------------------------------------------------------
test_main_pod_good {
	res := main with input as k8s.request_pod_good
	res.response.allowed = true
	isPatchResponse(res)
	patches = json.unmarshal(base64.decode(res.response.patch))
	
    some i
	hasPatch(patches, patch1.json[i])

    trace(sprintf("[test_main_pod_good] patches = '%s'", [patches]))
    

}

#-----------------------------------------------------------
# Test: patches are created for bad pod
#-----------------------------------------------------------
test_main_pod_bad {
	res := main with input as k8s.request_pod_bad
	res.response.allowed = true
	not isPatchResponse(res)

}