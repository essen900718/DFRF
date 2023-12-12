#!/bin/bash
iters="250000_head.tar"
names="Obama"
datasets="Obama"
near=0.7146276712417603
far=1.3146276712417602
path="dataset/finetune_models/${names}/${iters}"
datapath="dataset/${datasets}/0"
bc_type="torso_imgs"
suffix="val"
python NeRFs/run_nerf_deform.py --aud_file aud_cnn2_25fps.npy --need_torso True --config dataset/test_config.txt --expname ${names}_${suffix} --expname_finetune ${names}_${suffix} --render_only --ft_path ${path} --datadir ${datapath} --bc_type ${bc_type} --near ${near} --far ${far}

