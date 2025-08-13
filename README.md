# MI300X_GPTOSS_DEBUG

# Issue Reproduction:
1. Launch a container with the image: ```rocm/vllm-dev:open-mi300-08052025```
2. Serve VLLM with ```VLLM_ROCM_USE_AITER=1 VLLM_USE_AITER_UNIFIED_ATTENTION=1 VLLM_ROCM_USE_AITER_MHA=0 vllm serve openai/gpt-oss-120b  --compilation-config '{"full_cuda_graph": true}' & ```
3. Send prompt request 1st time, output is fine
4. Send same prompt request again, output is never ending "!!!!!!!!!!"

# Steps for suggested fix on AITER kernel level:
1. After launching the container, handle aiter change with ```sh aiter_fix.sh```
2. Run a one-line hotfix (sorryy) for import as such: ```sed -i 's|from aiter.ops.triton.unified_attention import unified_attention|from aiter.ops.triton.hybrid_attention_integration import enhanced_unified_attention as unified_attention|g' /app/vllm-os-mini/vllm/v1/attention/backends/triton_attn.py```
3. Try serving and sending requests again with this command: ```VLLM_FORCE_HYBRID_ATTENTION=1  VLLM_ROCM_USE_AITER=1 VLLM_USE_AITER_UNIFIED_ATTENTION=1 VLLM_ROCM_USE_AITER_MHA=0 vllm serve openai/gpt-oss-120b  --compilation-config '{"full_cuda_graph": true}' & ```

