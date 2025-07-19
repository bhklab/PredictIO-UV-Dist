#!/usr/bin/env nextflow
// hash:sha256:cfd1f9a72660a83295bf75ef9c20801db13e96801cb1c5c60f8a1cba0234cb93

nextflow.enable.dsl = 2

icb_gide_to_fl_gide_melanoma_immunotherapy_pd_1_pd_l1_dataset_1 = channel.fromPath("../data/ICB_Gide/*", type: 'any', relative: true)
icb_hugo_to_fl_hugo_melanoma_immunotherapy_pd_1_pd_l1_dataset_2 = channel.fromPath("../data/ICB_Hugo/*", type: 'any', relative: true)
icb_hwang_to_fl_hwang_lung_immunotherapy_pd_1_pd_l1_dataset_3 = channel.fromPath("../data/ICB_Hwang/*", type: 'any', relative: true)
icb_jung_to_fl_jung_lung_immunotherapy_pd_1_pd_l1_dataset_4 = channel.fromPath("../data/ICB_Jung/*", type: 'any', relative: true)
icb_kim_to_fl_kim_gastric_immunotherapy_pd_1_pd_l1_dataset_5 = channel.fromPath("../data/ICB_Kim/*", type: 'any', relative: true)
icb_limagne1_to_fl_limagne1_lung_immunotherapy_pd_1_pd_l1_dataset_6 = channel.fromPath("../data/ICB_Limagne1/*", type: 'any', relative: true)
icb_liu_combo_to_fl_liu_melanoma_immunotherapy_pd_1_pd_l1_and_ctla4_dataset_7 = channel.fromPath("../data/ICB_Liu_combo/*", type: 'any', relative: true)
icb_liu_to_fl_liu_melanoma_immunotherapy_pd_1_pd_l1_dataset_8 = channel.fromPath("../data/ICB_Liu/*", type: 'any', relative: true)
icb_limagne2_to_fl_limagne2_lung_immunotherapy_pd_1_pd_l1_dataset_9 = channel.fromPath("../data/ICB_Limagne2/*", type: 'any', relative: true)
icb_mariathasan_bladder_to_fl_mariathasan_bladder_immunotherapy_pd_1_pd_l1_dataset_10 = channel.fromPath("../data/ICB_Mariathasan_Bladder/*", type: 'any', relative: true)
icb_mariathasan_kidney_to_fl_mariathasan_kidney_immunotherapy_pd_1_pd_l1_dataset_11 = channel.fromPath("../data/ICB_Mariathasan_Kidney/*", type: 'any', relative: true)
icb_mariathasan_ureteral_to_fl_mariathasan_ureteral_immunotherapy_pd_1_pd_l1_dataset_12 = channel.fromPath("../data/ICB_Mariathasan_Ureteral/*", type: 'any', relative: true)
icb_miao1_to_fl_miao1_kidney_immunotherapy_pd_1_pd_l1_dataset_13 = channel.fromPath("../data/ICB_Miao1/*", type: 'any', relative: true)
icb_nathanson_to_fl_nathanson_melanoma_immunotherapy_ctla4_dataset_14 = channel.fromPath("../data/ICB_Nathanson/*", type: 'any', relative: true)
icb_padron_to_fl_padron_pancreas_immunotherapy_pd_1_pd_l1_dataset_15 = channel.fromPath("../data/ICB_Padron/*", type: 'any', relative: true)
icb_puch_to_fl_puch_melanoma_immunotherapy_pd_1_pd_l1_dataset_16 = channel.fromPath("../data/ICB_Puch/*", type: 'any', relative: true)
icb_snyder_to_fl_snyder_ureteral_immunotherapy_pd_1_pd_l1_dataset_17 = channel.fromPath("../data/ICB_Snyder/*", type: 'any', relative: true)
icb_shiuan_to_fl_shiuan_kidney_immunotherapy_pd_1_pd_l1_dataset_18 = channel.fromPath("../data/ICB_Shiuan/*", type: 'any', relative: true)
icb_roh_to_fl_roh_melanoma_immunotherapy_ctla4_dataset_19 = channel.fromPath("../data/ICB_Roh/*", type: 'any', relative: true)
icb_riaz_combo_to_fl_riaz_melanoma_immunotherapy_pd_1_pd_l1_and_ctla4_dataset_20 = channel.fromPath("../data/ICB_Riaz_combo/*", type: 'any', relative: true)
icb_riaz_to_fl_riaz_melanoma_immunotherapy_pd_1_pd_l1_dataset_21 = channel.fromPath("../data/ICB_Riaz/*", type: 'any', relative: true)
icb_vanallen_to_fl_van_allen_melanoma_immunotherapy_ctla4_dataset_22 = channel.fromPath("../data/ICB_VanAllen/*", type: 'any', relative: true)
capsule_fl_hugo_melanomaimmunotherapy_pd_1_pd_l_1_dataset_40_to_capsule_fl_immuno_oncologymeta_analysis_61_23 = channel.empty()
capsule_fl_gide_melanomaimmunotherapy_pd_1_pd_l_1_dataset_39_to_capsule_fl_immuno_oncologymeta_analysis_61_24 = channel.empty()
capsule_fl_puch_melanomaimmunotherapy_pd_1_pd_l_1_dataset_54_to_capsule_fl_immuno_oncologymeta_analysis_61_25 = channel.empty()
capsule_fl_snyder_ureteralimmunotherapy_pd_1_pd_l_1_dataset_55_to_capsule_fl_immuno_oncologymeta_analysis_61_26 = channel.empty()
capsule_fl_limagne_2_lungimmunotherapy_pd_1_pd_l_1_dataset_47_to_capsule_fl_immuno_oncologymeta_analysis_61_27 = channel.empty()
capsule_fl_liu_melanomaimmunotherapy_pd_1_pd_l_1_dataset_46_to_capsule_fl_immuno_oncologymeta_analysis_61_28 = channel.empty()
capsule_fl_hwang_lungimmunotherapy_pd_1_pd_l_1_dataset_41_to_capsule_fl_immuno_oncologymeta_analysis_61_29 = channel.empty()
capsule_fl_liu_melanomaimmunotherapy_pd_1_pd_l_1_and_ctla_4_dataset_45_to_capsule_fl_immuno_oncologymeta_analysis_61_30 = channel.empty()
capsule_fl_mariathasan_bladderimmunotherapy_pd_1_pd_l_1_dataset_48_to_capsule_fl_immuno_oncologymeta_analysis_61_31 = channel.empty()
capsule_fl_jung_lungimmunotherapy_pd_1_pd_l_1_dataset_42_to_capsule_fl_immuno_oncologymeta_analysis_61_32 = channel.empty()
capsule_fl_kim_gastricimmunotherapy_pd_1_pd_l_1_dataset_43_to_capsule_fl_immuno_oncologymeta_analysis_61_33 = channel.empty()
capsule_fl_mariathasan_kidneyimmunotherapy_pd_1_pd_l_1_dataset_49_to_capsule_fl_immuno_oncologymeta_analysis_61_34 = channel.empty()
capsule_fl_mariathasan_ureteralimmunotherapy_pd_1_pd_l_1_dataset_50_to_capsule_fl_immuno_oncologymeta_analysis_61_35 = channel.empty()
capsule_fl_limagne_1_lungimmunotherapy_pd_1_pd_l_1_dataset_44_to_capsule_fl_immuno_oncologymeta_analysis_61_36 = channel.empty()
capsule_fl_roh_melanomaimmunotherapy_ctla_4_dataset_57_to_capsule_fl_immuno_oncologymeta_analysis_61_37 = channel.empty()
capsule_fl_shiuan_kidneyimmunotherapy_pd_1_pd_l_1_dataset_56_to_capsule_fl_immuno_oncologymeta_analysis_61_38 = channel.empty()
capsule_fl_van_allen_melanomaimmunotherapy_ctla_4_dataset_60_to_capsule_fl_immuno_oncologymeta_analysis_61_39 = channel.empty()
capsule_fl_riaz_melanomaimmunotherapy_pd_1_pd_l_1_dataset_59_to_capsule_fl_immuno_oncologymeta_analysis_61_40 = channel.empty()
capsule_fl_riaz_melanomaimmunotherapy_pd_1_pd_l_1_and_ctla_4_dataset_58_to_capsule_fl_immuno_oncologymeta_analysis_61_41 = channel.empty()
capsule_fl_miao_1_kidneyimmunotherapy_pd_1_pd_l_1_dataset_51_to_capsule_fl_immuno_oncologymeta_analysis_61_42 = channel.empty()
capsule_fl_padron_pancreasimmunotherapy_pd_1_pd_l_1_dataset_53_to_capsule_fl_immuno_oncologymeta_analysis_61_43 = channel.empty()
capsule_fl_nathanson_melanomaimmunotherapy_ctla_4_dataset_52_to_capsule_fl_immuno_oncologymeta_analysis_61_44 = channel.empty()

// capsule - FL Gide Melanoma immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_gide_melanomaimmunotherapy_pd_1_pd_l_1_dataset_39 {
	tag 'capsule-8620643'
	container "registry.www.pmcodeocean.ca/published/53e9b5b0-dc9d-46c7-a333-99484345085e:v2"

	cpus 1
	memory '8 GB'

	input:
	val path1 from icb_gide_to_fl_gide_melanoma_immunotherapy_pd_1_pd_l1_dataset_1

	output:
	path 'capsule/results/*' into capsule_fl_gide_melanomaimmunotherapy_pd_1_pd_l_1_dataset_39_to_capsule_fl_immuno_oncologymeta_analysis_61_24

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=53e9b5b0-dc9d-46c7-a333-99484345085e
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Gide

	ln -s "/tmp/data/ICB_Gide/$path1" "capsule/data/ICB_Gide/$path1" # id: 59624ecb-30e4-4357-b713-0619948dbe96

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-8620643.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Hugo Melanoma immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_hugo_melanomaimmunotherapy_pd_1_pd_l_1_dataset_40 {
	tag 'capsule-4242543'
	container "registry.www.pmcodeocean.ca/published/96b694e6-da4f-4cf3-8c43-2d479b48a9cd:v2"

	cpus 1
	memory '8 GB'

	input:
	val path2 from icb_hugo_to_fl_hugo_melanoma_immunotherapy_pd_1_pd_l1_dataset_2

	output:
	path 'capsule/results/*' into capsule_fl_hugo_melanomaimmunotherapy_pd_1_pd_l_1_dataset_40_to_capsule_fl_immuno_oncologymeta_analysis_61_23

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=96b694e6-da4f-4cf3-8c43-2d479b48a9cd
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Hugo

	ln -s "/tmp/data/ICB_Hugo/$path2" "capsule/data/ICB_Hugo/$path2" # id: dd6832cf-d9c4-49f2-b673-730f44dc9158

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-4242543.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Hwang Lung immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_hwang_lungimmunotherapy_pd_1_pd_l_1_dataset_41 {
	tag 'capsule-0179392'
	container "registry.www.pmcodeocean.ca/published/a5ff6d9b-4fd2-48d5-9b6f-41366ea1cb96:v1"

	cpus 1
	memory '8 GB'

	input:
	val path3 from icb_hwang_to_fl_hwang_lung_immunotherapy_pd_1_pd_l1_dataset_3

	output:
	path 'capsule/results/*' into capsule_fl_hwang_lungimmunotherapy_pd_1_pd_l_1_dataset_41_to_capsule_fl_immuno_oncologymeta_analysis_61_29

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a5ff6d9b-4fd2-48d5-9b6f-41366ea1cb96
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Hwang

	ln -s "/tmp/data/ICB_Hwang/$path3" "capsule/data/ICB_Hwang/$path3" # id: 098776c4-0426-4f3b-a391-45efcb3b2e32

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-0179392.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Jung Lung immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_jung_lungimmunotherapy_pd_1_pd_l_1_dataset_42 {
	tag 'capsule-4470193'
	container "registry.www.pmcodeocean.ca/published/c1bc7953-ab8e-43bd-9f32-cf8e7a9cdecb:v1"

	cpus 1
	memory '8 GB'

	input:
	val path4 from icb_jung_to_fl_jung_lung_immunotherapy_pd_1_pd_l1_dataset_4

	output:
	path 'capsule/results/*' into capsule_fl_jung_lungimmunotherapy_pd_1_pd_l_1_dataset_42_to_capsule_fl_immuno_oncologymeta_analysis_61_32

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c1bc7953-ab8e-43bd-9f32-cf8e7a9cdecb
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Jung

	ln -s "/tmp/data/ICB_Jung/$path4" "capsule/data/ICB_Jung/$path4" # id: d7d3fe18-fefd-412c-b0ff-9cd62da8d74b

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-4470193.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Kim Gastric immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_kim_gastricimmunotherapy_pd_1_pd_l_1_dataset_43 {
	tag 'capsule-4587129'
	container "registry.www.pmcodeocean.ca/published/1cdbf51c-3a9a-46a1-8c74-d1ac8eb9e187:v1"

	cpus 1
	memory '8 GB'

	input:
	val path5 from icb_kim_to_fl_kim_gastric_immunotherapy_pd_1_pd_l1_dataset_5

	output:
	path 'capsule/results/*' into capsule_fl_kim_gastricimmunotherapy_pd_1_pd_l_1_dataset_43_to_capsule_fl_immuno_oncologymeta_analysis_61_33

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1cdbf51c-3a9a-46a1-8c74-d1ac8eb9e187
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Kim

	ln -s "/tmp/data/ICB_Kim/$path5" "capsule/data/ICB_Kim/$path5" # id: f2a097c6-cb5b-44f7-a9c3-317df8591448

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-4587129.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Limagne1 Lung immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_limagne_1_lungimmunotherapy_pd_1_pd_l_1_dataset_44 {
	tag 'capsule-5708800'
	container "registry.www.pmcodeocean.ca/published/b3e5e926-d43e-44df-a238-5670fd8656b9:v2"

	cpus 1
	memory '8 GB'

	input:
	val path6 from icb_limagne1_to_fl_limagne1_lung_immunotherapy_pd_1_pd_l1_dataset_6

	output:
	path 'capsule/results/*' into capsule_fl_limagne_1_lungimmunotherapy_pd_1_pd_l_1_dataset_44_to_capsule_fl_immuno_oncologymeta_analysis_61_36

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b3e5e926-d43e-44df-a238-5670fd8656b9
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Limagne1

	ln -s "/tmp/data/ICB_Limagne1/$path6" "capsule/data/ICB_Limagne1/$path6" # id: c57eee20-b815-4fbf-a7b9-67143b421537

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-5708800.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Liu Melanoma immunotherapy (PD-1/PD-L1 and CTLA4) dataset
process capsule_fl_liu_melanomaimmunotherapy_pd_1_pd_l_1_and_ctla_4_dataset_45 {
	tag 'capsule-4055632'
	container "registry.www.pmcodeocean.ca/published/290909c1-5ec7-4092-84c4-3cb671812604:v2"

	cpus 1
	memory '8 GB'

	input:
	val path7 from icb_liu_combo_to_fl_liu_melanoma_immunotherapy_pd_1_pd_l1_and_ctla4_dataset_7

	output:
	path 'capsule/results/*' into capsule_fl_liu_melanomaimmunotherapy_pd_1_pd_l_1_and_ctla_4_dataset_45_to_capsule_fl_immuno_oncologymeta_analysis_61_30

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=290909c1-5ec7-4092-84c4-3cb671812604
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Liu_combo

	ln -s "/tmp/data/ICB_Liu_combo/$path7" "capsule/data/ICB_Liu_combo/$path7" # id: 4ebdc664-3b01-449f-bbac-84f732f7b30b

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-4055632.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Liu Melanoma immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_liu_melanomaimmunotherapy_pd_1_pd_l_1_dataset_46 {
	tag 'capsule-2123049'
	container "registry.www.pmcodeocean.ca/published/db515be5-ff82-4cea-b0eb-4c7d8fb169b8:v2"

	cpus 1
	memory '8 GB'

	input:
	val path8 from icb_liu_to_fl_liu_melanoma_immunotherapy_pd_1_pd_l1_dataset_8

	output:
	path 'capsule/results/*' into capsule_fl_liu_melanomaimmunotherapy_pd_1_pd_l_1_dataset_46_to_capsule_fl_immuno_oncologymeta_analysis_61_28

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=db515be5-ff82-4cea-b0eb-4c7d8fb169b8
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Liu

	ln -s "/tmp/data/ICB_Liu/$path8" "capsule/data/ICB_Liu/$path8" # id: 9c4892bb-866a-4cae-a03c-a4687e9896a0

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-2123049.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Limagne2 Lung immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_limagne_2_lungimmunotherapy_pd_1_pd_l_1_dataset_47 {
	tag 'capsule-2685182'
	container "registry.www.pmcodeocean.ca/published/0ccc3e0a-94a0-4707-ad18-088ca1a72fe3:v1"

	cpus 1
	memory '8 GB'

	input:
	val path9 from icb_limagne2_to_fl_limagne2_lung_immunotherapy_pd_1_pd_l1_dataset_9

	output:
	path 'capsule/results/*' into capsule_fl_limagne_2_lungimmunotherapy_pd_1_pd_l_1_dataset_47_to_capsule_fl_immuno_oncologymeta_analysis_61_27

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=0ccc3e0a-94a0-4707-ad18-088ca1a72fe3
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Limagne2

	ln -s "/tmp/data/ICB_Limagne2/$path9" "capsule/data/ICB_Limagne2/$path9" # id: d6040b7f-b0c5-467c-8c8d-46c291f142a0

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-2685182.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Mariathasan Bladder immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_mariathasan_bladderimmunotherapy_pd_1_pd_l_1_dataset_48 {
	tag 'capsule-2866110'
	container "registry.www.pmcodeocean.ca/published/56eec2bf-84d6-46b2-a5ce-2c5c975b188e:v1"

	cpus 1
	memory '8 GB'

	input:
	val path10 from icb_mariathasan_bladder_to_fl_mariathasan_bladder_immunotherapy_pd_1_pd_l1_dataset_10

	output:
	path 'capsule/results/*' into capsule_fl_mariathasan_bladderimmunotherapy_pd_1_pd_l_1_dataset_48_to_capsule_fl_immuno_oncologymeta_analysis_61_31

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=56eec2bf-84d6-46b2-a5ce-2c5c975b188e
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Mariathasan_Bladder

	ln -s "/tmp/data/ICB_Mariathasan_Bladder/$path10" "capsule/data/ICB_Mariathasan_Bladder/$path10" # id: d9b60b31-8bc4-481c-8e9f-313eac32e58e

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-2866110.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Mariathasan Kidney immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_mariathasan_kidneyimmunotherapy_pd_1_pd_l_1_dataset_49 {
	tag 'capsule-6631933'
	container "registry.www.pmcodeocean.ca/published/c398d8a1-223a-484b-92d7-b838d95d7ec5:v1"

	cpus 1
	memory '8 GB'

	input:
	val path11 from icb_mariathasan_kidney_to_fl_mariathasan_kidney_immunotherapy_pd_1_pd_l1_dataset_11

	output:
	path 'capsule/results/*' into capsule_fl_mariathasan_kidneyimmunotherapy_pd_1_pd_l_1_dataset_49_to_capsule_fl_immuno_oncologymeta_analysis_61_34

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c398d8a1-223a-484b-92d7-b838d95d7ec5
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Mariathasan_Kidney

	ln -s "/tmp/data/ICB_Mariathasan_Kidney/$path11" "capsule/data/ICB_Mariathasan_Kidney/$path11" # id: f89aa877-c8a1-4e1c-976c-691470a7ee2d

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-6631933.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Mariathasan Ureteral immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_mariathasan_ureteralimmunotherapy_pd_1_pd_l_1_dataset_50 {
	tag 'capsule-1357576'
	container "registry.www.pmcodeocean.ca/published/488c7bbc-0add-4683-bc4a-56cd721eef47:v1"

	cpus 1
	memory '8 GB'

	input:
	val path12 from icb_mariathasan_ureteral_to_fl_mariathasan_ureteral_immunotherapy_pd_1_pd_l1_dataset_12

	output:
	path 'capsule/results/*' into capsule_fl_mariathasan_ureteralimmunotherapy_pd_1_pd_l_1_dataset_50_to_capsule_fl_immuno_oncologymeta_analysis_61_35

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=488c7bbc-0add-4683-bc4a-56cd721eef47
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Mariathasan_Ureteral

	ln -s "/tmp/data/ICB_Mariathasan_Ureteral/$path12" "capsule/data/ICB_Mariathasan_Ureteral/$path12" # id: a83e50cc-05a9-444c-bce3-7355484385af

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-1357576.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Miao1 Kidney immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_miao_1_kidneyimmunotherapy_pd_1_pd_l_1_dataset_51 {
	tag 'capsule-1043481'
	container "registry.www.pmcodeocean.ca/published/390b4881-7eda-4a1a-91d8-e326de14b567:v1"

	cpus 1
	memory '8 GB'

	input:
	val path13 from icb_miao1_to_fl_miao1_kidney_immunotherapy_pd_1_pd_l1_dataset_13

	output:
	path 'capsule/results/*' into capsule_fl_miao_1_kidneyimmunotherapy_pd_1_pd_l_1_dataset_51_to_capsule_fl_immuno_oncologymeta_analysis_61_42

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=390b4881-7eda-4a1a-91d8-e326de14b567
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Miao1

	ln -s "/tmp/data/ICB_Miao1/$path13" "capsule/data/ICB_Miao1/$path13" # id: 5e6508d1-6abe-4c4c-9795-8e417b71e986

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-1043481.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Nathanson Melanoma immunotherapy (CTLA4) dataset
process capsule_fl_nathanson_melanomaimmunotherapy_ctla_4_dataset_52 {
	tag 'capsule-0956691'
	container "registry.www.pmcodeocean.ca/published/9315bd18-5246-487b-8f84-b5aaee829bec:v1"

	cpus 1
	memory '8 GB'

	input:
	val path14 from icb_nathanson_to_fl_nathanson_melanoma_immunotherapy_ctla4_dataset_14

	output:
	path 'capsule/results/*' into capsule_fl_nathanson_melanomaimmunotherapy_ctla_4_dataset_52_to_capsule_fl_immuno_oncologymeta_analysis_61_44

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9315bd18-5246-487b-8f84-b5aaee829bec
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Nathanson

	ln -s "/tmp/data/ICB_Nathanson/$path14" "capsule/data/ICB_Nathanson/$path14" # id: 51914e65-ff86-4de8-8452-17c38c1fdb11

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-0956691.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Padron Pancreas immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_padron_pancreasimmunotherapy_pd_1_pd_l_1_dataset_53 {
	tag 'capsule-8331031'
	container "registry.www.pmcodeocean.ca/published/41ea63aa-3847-4f13-b036-48430d18e6a4:v2"

	cpus 1
	memory '8 GB'

	input:
	val path15 from icb_padron_to_fl_padron_pancreas_immunotherapy_pd_1_pd_l1_dataset_15

	output:
	path 'capsule/results/*' into capsule_fl_padron_pancreasimmunotherapy_pd_1_pd_l_1_dataset_53_to_capsule_fl_immuno_oncologymeta_analysis_61_43

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=41ea63aa-3847-4f13-b036-48430d18e6a4
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Padron

	ln -s "/tmp/data/ICB_Padron/$path15" "capsule/data/ICB_Padron/$path15" # id: fef3bfb9-ee87-432f-8a77-25ec62b9c40e

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-8331031.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Puch Melanoma immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_puch_melanomaimmunotherapy_pd_1_pd_l_1_dataset_54 {
	tag 'capsule-0243074'
	container "registry.www.pmcodeocean.ca/published/1406ea67-355d-4d09-a2ac-d459c19a3942:v2"

	cpus 1
	memory '8 GB'

	input:
	val path16 from icb_puch_to_fl_puch_melanoma_immunotherapy_pd_1_pd_l1_dataset_16

	output:
	path 'capsule/results/*' into capsule_fl_puch_melanomaimmunotherapy_pd_1_pd_l_1_dataset_54_to_capsule_fl_immuno_oncologymeta_analysis_61_25

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1406ea67-355d-4d09-a2ac-d459c19a3942
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Puch

	ln -s "/tmp/data/ICB_Puch/$path16" "capsule/data/ICB_Puch/$path16" # id: af7af4ae-5ff0-41a1-86b1-e02c7b2f6347

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-0243074.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Snyder Ureteral immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_snyder_ureteralimmunotherapy_pd_1_pd_l_1_dataset_55 {
	tag 'capsule-6947481'
	container "registry.www.pmcodeocean.ca/published/91eb65c4-6d9d-4985-aa96-73bbd7518fad:v2"

	cpus 1
	memory '8 GB'

	input:
	val path17 from icb_snyder_to_fl_snyder_ureteral_immunotherapy_pd_1_pd_l1_dataset_17

	output:
	path 'capsule/results/*' into capsule_fl_snyder_ureteralimmunotherapy_pd_1_pd_l_1_dataset_55_to_capsule_fl_immuno_oncologymeta_analysis_61_26

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=91eb65c4-6d9d-4985-aa96-73bbd7518fad
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Snyder

	ln -s "/tmp/data/ICB_Snyder/$path17" "capsule/data/ICB_Snyder/$path17" # id: 6d10f33b-a4c7-4d19-a7d5-3b7ab461d20a

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-6947481.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Shiuan Kidney immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_shiuan_kidneyimmunotherapy_pd_1_pd_l_1_dataset_56 {
	tag 'capsule-6514778'
	container "registry.www.pmcodeocean.ca/published/0b453953-64dc-4986-977e-97c9c02870ff:v2"

	cpus 1
	memory '8 GB'

	input:
	val path18 from icb_shiuan_to_fl_shiuan_kidney_immunotherapy_pd_1_pd_l1_dataset_18

	output:
	path 'capsule/results/*' into capsule_fl_shiuan_kidneyimmunotherapy_pd_1_pd_l_1_dataset_56_to_capsule_fl_immuno_oncologymeta_analysis_61_38

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=0b453953-64dc-4986-977e-97c9c02870ff
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Shiuan

	ln -s "/tmp/data/ICB_Shiuan/$path18" "capsule/data/ICB_Shiuan/$path18" # id: c2de4e39-e781-42a7-9044-eec9ebdf6372

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-6514778.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Roh Melanoma immunotherapy (CTLA4) dataset
process capsule_fl_roh_melanomaimmunotherapy_ctla_4_dataset_57 {
	tag 'capsule-4304069'
	container "registry.www.pmcodeocean.ca/published/278c64df-eda6-4a3f-abd9-22b4e8362167:v3"

	cpus 1
	memory '8 GB'

	input:
	val path19 from icb_roh_to_fl_roh_melanoma_immunotherapy_ctla4_dataset_19

	output:
	path 'capsule/results/*' into capsule_fl_roh_melanomaimmunotherapy_ctla_4_dataset_57_to_capsule_fl_immuno_oncologymeta_analysis_61_37

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=278c64df-eda6-4a3f-abd9-22b4e8362167
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Roh

	ln -s "/tmp/data/ICB_Roh/$path19" "capsule/data/ICB_Roh/$path19" # id: 4f946f1e-c0a6-402b-bdf2-86ace37ad3f9

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-4304069.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Riaz Melanoma immunotherapy (PD-1/PD-L1 and CTLA4) dataset
process capsule_fl_riaz_melanomaimmunotherapy_pd_1_pd_l_1_and_ctla_4_dataset_58 {
	tag 'capsule-1086268'
	container "registry.www.pmcodeocean.ca/published/e78feaa4-12b4-461f-bfcd-a1f48125e7d8:v2"

	cpus 1
	memory '8 GB'

	input:
	val path20 from icb_riaz_combo_to_fl_riaz_melanoma_immunotherapy_pd_1_pd_l1_and_ctla4_dataset_20

	output:
	path 'capsule/results/*' into capsule_fl_riaz_melanomaimmunotherapy_pd_1_pd_l_1_and_ctla_4_dataset_58_to_capsule_fl_immuno_oncologymeta_analysis_61_41

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e78feaa4-12b4-461f-bfcd-a1f48125e7d8
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Riaz_combo

	ln -s "/tmp/data/ICB_Riaz_combo/$path20" "capsule/data/ICB_Riaz_combo/$path20" # id: 0ca52af6-a6f6-4825-b3df-de566acd0b9a

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-1086268.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Riaz Melanoma immunotherapy (PD-1/PD-L1) dataset
process capsule_fl_riaz_melanomaimmunotherapy_pd_1_pd_l_1_dataset_59 {
	tag 'capsule-3408394'
	container "registry.www.pmcodeocean.ca/published/599060d4-9075-4a12-86ba-9d64b4f8ad5b:v2"

	cpus 1
	memory '8 GB'

	input:
	val path21 from icb_riaz_to_fl_riaz_melanoma_immunotherapy_pd_1_pd_l1_dataset_21

	output:
	path 'capsule/results/*' into capsule_fl_riaz_melanomaimmunotherapy_pd_1_pd_l_1_dataset_59_to_capsule_fl_immuno_oncologymeta_analysis_61_40

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=599060d4-9075-4a12-86ba-9d64b4f8ad5b
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_Riaz

	ln -s "/tmp/data/ICB_Riaz/$path21" "capsule/data/ICB_Riaz/$path21" # id: 2f5345d4-2075-41a9-a0db-d08daf41b984

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-3408394.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Van Allen Melanoma immunotherapy (CTLA4) dataset
process capsule_fl_van_allen_melanomaimmunotherapy_ctla_4_dataset_60 {
	tag 'capsule-0905062'
	container "registry.www.pmcodeocean.ca/published/10c943bd-d673-4b79-a063-67b30701dd01:v2"

	cpus 1
	memory '8 GB'

	input:
	val path22 from icb_vanallen_to_fl_van_allen_melanoma_immunotherapy_ctla4_dataset_22

	output:
	path 'capsule/results/*' into capsule_fl_van_allen_melanomaimmunotherapy_ctla_4_dataset_60_to_capsule_fl_immuno_oncologymeta_analysis_61_39

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=10c943bd-d673-4b79-a063-67b30701dd01
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/ICB_VanAllen

	ln -s "/tmp/data/ICB_VanAllen/$path22" "capsule/data/ICB_VanAllen/$path22" # id: 5b993e46-63f6-49a1-8fbf-462e52f10e10

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-0905062.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - FL Immuno-Oncology meta-analysis
process capsule_fl_immuno_oncologymeta_analysis_61 {
	tag 'capsule-4357016'
	container "registry.www.pmcodeocean.ca/published/9173e5e8-efc3-4a57-a47d-4e97df8dc8d8:v2"

	cpus 1
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_fl_hugo_melanomaimmunotherapy_pd_1_pd_l_1_dataset_40_to_capsule_fl_immuno_oncologymeta_analysis_61_23.collect()
	path 'capsule/data/' from capsule_fl_gide_melanomaimmunotherapy_pd_1_pd_l_1_dataset_39_to_capsule_fl_immuno_oncologymeta_analysis_61_24.collect()
	path 'capsule/data/' from capsule_fl_puch_melanomaimmunotherapy_pd_1_pd_l_1_dataset_54_to_capsule_fl_immuno_oncologymeta_analysis_61_25.collect()
	path 'capsule/data/' from capsule_fl_snyder_ureteralimmunotherapy_pd_1_pd_l_1_dataset_55_to_capsule_fl_immuno_oncologymeta_analysis_61_26.collect()
	path 'capsule/data/' from capsule_fl_limagne_2_lungimmunotherapy_pd_1_pd_l_1_dataset_47_to_capsule_fl_immuno_oncologymeta_analysis_61_27.collect()
	path 'capsule/data/' from capsule_fl_liu_melanomaimmunotherapy_pd_1_pd_l_1_dataset_46_to_capsule_fl_immuno_oncologymeta_analysis_61_28.collect()
	path 'capsule/data/' from capsule_fl_hwang_lungimmunotherapy_pd_1_pd_l_1_dataset_41_to_capsule_fl_immuno_oncologymeta_analysis_61_29.collect()
	path 'capsule/data/' from capsule_fl_liu_melanomaimmunotherapy_pd_1_pd_l_1_and_ctla_4_dataset_45_to_capsule_fl_immuno_oncologymeta_analysis_61_30.collect()
	path 'capsule/data/' from capsule_fl_mariathasan_bladderimmunotherapy_pd_1_pd_l_1_dataset_48_to_capsule_fl_immuno_oncologymeta_analysis_61_31.collect()
	path 'capsule/data/' from capsule_fl_jung_lungimmunotherapy_pd_1_pd_l_1_dataset_42_to_capsule_fl_immuno_oncologymeta_analysis_61_32.collect()
	path 'capsule/data/' from capsule_fl_kim_gastricimmunotherapy_pd_1_pd_l_1_dataset_43_to_capsule_fl_immuno_oncologymeta_analysis_61_33.collect()
	path 'capsule/data/' from capsule_fl_mariathasan_kidneyimmunotherapy_pd_1_pd_l_1_dataset_49_to_capsule_fl_immuno_oncologymeta_analysis_61_34.collect()
	path 'capsule/data/' from capsule_fl_mariathasan_ureteralimmunotherapy_pd_1_pd_l_1_dataset_50_to_capsule_fl_immuno_oncologymeta_analysis_61_35.collect()
	path 'capsule/data/' from capsule_fl_limagne_1_lungimmunotherapy_pd_1_pd_l_1_dataset_44_to_capsule_fl_immuno_oncologymeta_analysis_61_36.collect()
	path 'capsule/data/' from capsule_fl_roh_melanomaimmunotherapy_ctla_4_dataset_57_to_capsule_fl_immuno_oncologymeta_analysis_61_37.collect()
	path 'capsule/data/' from capsule_fl_shiuan_kidneyimmunotherapy_pd_1_pd_l_1_dataset_56_to_capsule_fl_immuno_oncologymeta_analysis_61_38.collect()
	path 'capsule/data/' from capsule_fl_van_allen_melanomaimmunotherapy_ctla_4_dataset_60_to_capsule_fl_immuno_oncologymeta_analysis_61_39.collect()
	path 'capsule/data/' from capsule_fl_riaz_melanomaimmunotherapy_pd_1_pd_l_1_dataset_59_to_capsule_fl_immuno_oncologymeta_analysis_61_40.collect()
	path 'capsule/data/' from capsule_fl_riaz_melanomaimmunotherapy_pd_1_pd_l_1_and_ctla_4_dataset_58_to_capsule_fl_immuno_oncologymeta_analysis_61_41.collect()
	path 'capsule/data/' from capsule_fl_miao_1_kidneyimmunotherapy_pd_1_pd_l_1_dataset_51_to_capsule_fl_immuno_oncologymeta_analysis_61_42.collect()
	path 'capsule/data/' from capsule_fl_padron_pancreasimmunotherapy_pd_1_pd_l_1_dataset_53_to_capsule_fl_immuno_oncologymeta_analysis_61_43.collect()
	path 'capsule/data/' from capsule_fl_nathanson_melanomaimmunotherapy_ctla_4_dataset_52_to_capsule_fl_immuno_oncologymeta_analysis_61_44.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9173e5e8-efc3-4a57-a47d-4e97df8dc8d8
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@www.pmcodeocean.ca/capsule-4357016.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
