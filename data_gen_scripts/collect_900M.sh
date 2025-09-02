# Run 20 processes in parallel, each handling SEED_PER_PROCESS seeds
ENV_NAME=${1}
START_SEED=${2}
SEED_PER_PROCESS=${3}
LOOP_COUNT=${4}
for j in $(seq ${START_SEED} $(( ${START_SEED} + ${SEED_PER_PROCESS} ))); do
    (
        for i in $(seq -w $(( j * ${LOOP_COUNT} )) $(( (j + 1) * ${LOOP_COUNT} - 1 ))); do
            python generate_manipspace.py --seed=$i --env_name=${ENV_NAME} --save_path=/mnt/changyeon/corl2025/ogbench/${ENV_NAME}-play-1B-v0/${ENV_NAME}-play-v0-$i.npz --num_episodes=1000 --max_episode_steps=1001 --dataset_type=play;
        done
    ) &
done

# Wait for all background processes to complete
wait

