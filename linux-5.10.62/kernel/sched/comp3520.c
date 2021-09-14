#include "linux/list.h"
#include "linux/types.h"
#include "sched.h"
#include "pelt.h"

const struct sched_class comp3520_sched_class;

static void enqueue_task_comp3520(struct rq *rq, struct task_struct *p,
				  int flags)
{
	struct comp3520_rq *comp3520_rq = rq->comp3520;
	struct sched_comp3520_entity *se = &p->comp3520_se;

}

static void dequeue_task_comp3520(struct rq *rq, struct task_struct *p,
				  int flags)
{
	struct comp3520_rq *comp3520_rq = &rq->comp3520;
	struct sched_comp3520_entity *se = &p->comp3520_se;

}

static void yield_task_comp3520(struct rq *rq)
{
};

static bool yield_to_task_comp3520(struct rq *rq, struct task_struct *p)
{
	struct comp3520_rq *comp3520_rq;
	struct sched_comp3520_entity *se = &p->comp3520_se;

	return false;
}

static void check_preempt_curr_comp3520(struct rq *rq, struct task_struct *p,
					int wake_flags)
{
	struct comp3520_rq *comp3520_rq;
	struct sched_comp3520_entity *se = &p->comp3520_se;
}

struct task_struct *pick_next_task_comp3520(struct rq *rq)
{
	return NULL;
}

static void put_prev_task_comp3520(struct rq *rq, struct task_struct *prev)
{
	struct comp3520_rq *comp3520_rq;
	struct sched_comp3520_entity *se = &p->comp3520_se;
}

static void set_next_task_comp3520(struct rq *rq, struct task_struct *p,
				   bool first)
{
	struct comp3520_rq *comp3520_rq;
	struct sched_comp3520_entity *se = &p->comp3520_se;
}
static void task_tick_comp3520(struct rq *rq, struct task_struct *curr,
			       int queued)
{
}

static void task_fork_comp3520(struct task_struct *p)
{
	struct comp3520_rq *comp3520_rq;
	struct sched_comp3520_entity *se = &p->comp3520_se;
}
static void prio_changed_comp3520(struct rq *rq, struct task_struct *p,
				  int oldprio)
{
	struct comp3520_rq *comp3520_rq;
	struct sched_comp3520_entity *se = &p->comp3520_se;
}

static void switched_from_comp3520(struct rq *rq, struct task_struct *p)
{
	struct comp3520_rq *comp3520_rq;
	struct sched_comp3520_entity *se = &p->comp3520_se;
}

static void switched_to_comp3520(struct rq *rq, struct task_struct *p)
{
	struct comp3520_rq *comp3520_rq;
	struct sched_comp3520_entity *se = &p->comp3520_se;
}

static unsigned int get_rr_interval_comp3520(struct rq *rq,
					     struct task_struct *task)
{
	return 0;
}

static void update_curr_comp3520(struct rq *rq)
{
}

const struct sched_class
	comp3520_sched_class __section("__comp3520_sched_class") = {
		.enqueue_task = enqueue_task_comp3520,
		.dequeue_task = dequeue_task_comp3520,
		.yield_task = yield_task_comp3520,
		.yield_to_task = yield_to_task_comp3520,

		.check_preempt_curr = check_preempt_curr_comp3520,

		.pick_next_task = pick_next_task_comp3520,
		.put_prev_task = put_prev_task_comp3520,
		.set_next_task = set_next_task_comp3520,

#ifdef CONFIG_SMP
		.balance = balance_comp3520,
		.select_task_rq = select_task_rq_comp3520,
		.migrate_task_rq = migrate_task_rq_comp3520,

		.rq_online = rq_online_comp3520,
		.rq_offline = rq_offline_comp3520,

		.task_dead = task_dead_comp3520,
		.set_cpus_allowed = set_cpus_allowed_common,
#endif

		.task_tick = task_tick_comp3520,
		.task_fork = task_fork_comp3520,

		.prio_changed = prio_changed_comp3520,
		.switched_from = switched_from_comp3520,
		.switched_to = switched_to_comp3520,

		.get_rr_interval = get_rr_interval_comp3520,

		.update_curr = update_curr_comp3520,

#ifdef CONFIG_UCLAMP_TASK
		.uclamp_enabled = 1,
#endif

	};

void init_comp3520_rq(struct comp3520_rq *comp3520_rq)
{
	comp3520_rq->nr_running = 0;
	comp3520_rq->curr = NULL;
	INIT_LIST_HEAD(&comp3520_rq->entity_list);
}

#ifdef CONFIG_SCHED_DEBUG
extern void print_comp3520_stats(struct seq_file *m, int cpu);
extern void print_comp3520_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
#endif
